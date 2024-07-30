//
//  PopularViewController.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit

protocol PopularViewProtocol: AnyObject {
    
}

final class PopularViewController: ViewController, PopularViewProtocol {
    // MARK: - Public Properties
    var presenter: PopularPresenterProtocol!
    
    // MARK: - Private Properties
    private var popularView: PopularView!
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        popularView = PopularView()
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
}

// MARK: - Set Delegates
private extension PopularViewController {
    func setDelegates() {
        popularView.radioCollectionViewDataSource = self
        popularView.radioCollectionViewDelegate = self
    }
}

// MARK: - RadioCollectionView DataSource methods
extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}

// MARK: - RadioCollectionView Delegate methods
extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("row #\(indexPath.row)")
    }
}

// MARK: - RadioCollectionView FlowLayout Delegate methods
extension PopularViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 15.0
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = (numberOfItemsPerRow - 1) * interItemSpacing
        let itemSize = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: itemSize, height: itemSize)
    }
}
