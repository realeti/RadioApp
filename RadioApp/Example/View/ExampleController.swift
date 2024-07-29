//
//  ExampleController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit

typealias ExampleCell = CollectionCell<ExampleCellView>

class ExampleController: ViewController {
    var presenter: (any ExamplePresenterProtocol)?
    
    private lazy var collectionView: UICollectionView = createCollectionView()
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable> = createDataSource()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.activate()
    }
}

extension ExampleController: ExampleControllerProtocol {
    struct Model {
        let examples: [Example]
    }
    
    func update(with model: Model) {
        updateCollection(with: model)
    }
}

private extension ExampleController {
    func updateCollection(with model: Model) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.searchSecction, .examplesSection])
        snapshot.appendItems(model.examples, toSection: .examplesSection)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

private extension ExampleController {
    func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionalLayout())
        collectionView.register(ExampleCell.self, forCellWithReuseIdentifier: String(describing: ExampleCell.self))
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return collectionView
    }
    
    private func createDataSource() -> UICollectionViewDiffableDataSource<Section, AnyHashable> {
        return UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) { collectionView, indexPath, item in
            guard let sectionType = Section(rawValue: indexPath.section) else { return UICollectionViewCell()}
            switch sectionType {
            case .examplesSection:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ExampleCell.self), for: indexPath) as! ExampleCell
                print(item)
                if let exampleModel = item as? Example {
                    cell.update(with: exampleModel, didSelectHandler: { print("") })
                }
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
}

private extension ExampleController {
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
            config.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout.init { sectionIndex, _ in
            let sectionType = Section(rawValue: sectionIndex)!
            switch sectionType {
            case .searchSecction:
                return self.searchSection()
            case .examplesSection:
                return self.examplesSection()
            }
        }
        layout.configuration = config
        return layout
    }
    
    func searchSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 0
        collectionView.showsVerticalScrollIndicator = false
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    func examplesSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(112)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 0
        collectionView.showsVerticalScrollIndicator = false
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
}

private extension ExampleController {
    private enum Section: Int, CaseIterable {
        case searchSecction
        case examplesSection
    }
}

extension ExampleController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //...
    }
}
