//
//  FavoriteRadioView.swift
//  RadioApp
//
//  Created by Natalia on 30.07.2024.
//

import UIKit

class FavoriteRadioView: UIView, CellConfigurable {
    
    private var favoriteHandler: (() -> Void)?
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        return label
    }()
    
    private let image: UIImageView = {
        let image = UIImage(named: "vawe")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private let favImage: UIImageView = {
        let image = UIImage(named: "favOn")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    private let stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .leading
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.layer.borderColor = UIColor.border.cgColor
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(stackView)
        addSubview(favImage)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(image)
        
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints { 
            $0.top.equalToSuperview().inset(18)
            $0.leading.equalToSuperview().inset(22)
            $0.bottom.equalToSuperview().inset(15)
        }
        
        favImage.snp.makeConstraints {
            $0.top.equalToSuperview().inset(31)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    func update(with model: FavoritesModel?) {
        titleLabel.text = model?.radioTitle
        genreLabel.text = model?.genre
        favoriteHandler = model?.favoriteHandler
    }
}
