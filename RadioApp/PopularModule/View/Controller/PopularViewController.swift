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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.popularRadioCell, for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell()
        }
        //cell.configure(with: )
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

final class TestController: UIViewController {
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .martimeBlue
        view.progressTintColor = .neonBlueApp
        view.progress = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkBlueApp
        view.addSubview(containerView)
        containerView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.0),
            containerView.widthAnchor.constraint(equalToConstant: 5.0),
            containerView.heightAnchor.constraint(equalToConstant: 200.0),
            
            /*progressView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            progressView.widthAnchor.constraint(equalTo: containerView.heightAnchor),
            progressView.heightAnchor.constraint(equalTo: containerView.widthAnchor)*/
            
            progressView.topAnchor.constraint(equalTo: containerView.topAnchor),
            progressView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        progressView.transform = CGAffineTransform(rotationAngle: .pi / -2)
    }
}
