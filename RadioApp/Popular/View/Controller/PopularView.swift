//
//  PopularView.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit
import SnapKit

final class PopularView: UIView {
    // MARK: - UI
    private let titleLabel = UILabel(
        text: K.Popular.title.rawValue.localized,
        font: .systemFont(ofSize: 30.0, weight: .light)
    )
    
    private lazy var radioCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 14.0 // vertical spacing
        flowLayout.minimumInteritemSpacing = 15.0 // horizontal spacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: K.popularRadioCell)
        return collectionView
    }()
    
    // MARK: - Public Properties
    var radioCollection: UICollectionView {
        get { radioCollectionView }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Views
    private func setupUI() {
        addSubviews(titleLabel, radioCollectionView)
    }
}

// MARK: - Setup Constraints
private extension PopularView {
    func setupConstraints() {
        setupTitleLabelConstraints()
        setupRadioCollectionConstraints()
    }
    
    func setupTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(Metrics.titleTopIndent)
            make.leading.equalToSuperview().inset(Metrics.titleLeadingIndent)
        }
    }
    
    func setupRadioCollectionConstraints() {
        radioCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Metrics.radioCollectionTopIndent)
            make.leading.equalToSuperview().inset(Metrics.radioCollectionLeadingIndent)
            make.trailing.equalToSuperview().inset(Metrics.radioCollectionTrailingIndent)
            make.bottom.equalToSuperview().inset(K.audioPlayerHeight + K.audioPlayerBottomIndent)
        }
    }
}

// MARK: - Metrics
fileprivate struct Metrics {
    /// title label
    static let titleTopIndent: CGFloat = 28.0
    static let titleLeadingIndent: CGFloat = 66.0
    
    /// radio collection
    static let radioCollectionTopIndent: CGFloat = 25.8
    static let radioCollectionLeadingIndent: CGFloat = 50.0
    static let radioCollectionTrailingIndent: CGFloat = 50.0
    
    private init() {}
}
