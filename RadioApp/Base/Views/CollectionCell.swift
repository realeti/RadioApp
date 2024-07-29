//
//  CollectionCell.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit
import SnapKit

class CollectionCell<View: CellConfigurable>: UICollectionViewCell {
    private let view = View()
    private let stackView = UIStackView()
    private var didSelectHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        view.update(with: nil)
        backgroundColor = .clear
    }
    
    func update(
        with model: View.Model,
        didSelectHandler: (() -> Void)? = nil
    ) {
        view.update(with: model)
        self.didSelectHandler = didSelectHandler
    }
    
    private func configure() {
        backgroundColor = .clear
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelect))
        tapRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc private func didSelect() {
        didSelectHandler?()
    }
}
