//
//  CustomSettingsView.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import UIKit

final class CustomSettingsView: UIView {
    
    private var iconView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var arrowView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .darkGray
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        
        let imageView = UIImageView(image: UIImage(systemName: "chevron.forward"))
        imageView.tintColor = .neonBlueApp
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(22)
        }
        
        return containerView
    }()
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        configure(title: "", image: UIImage())
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(title: String, image: UIImage) {
        iconView = createIconView(with: image)
        
        nameLabel = UILabel.makeLabel(
            font: .systemFont(ofSize: 14, weight: .medium),
            color: .white,
            numberOfLines: 1,
            alignment: .left
        )
        nameLabel.text = title
        setViews()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    private func createIconView(with image: UIImage) -> UIView {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 16
        
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(6)
        }
        return view
    }
}

// MARK: - Setup UI
private extension CustomSettingsView {
    func setViews() {
        addSubviews(iconView, nameLabel, arrowView)
    }
    
    func setupConstraints() {
        iconView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.width.equalTo(32)
            make.left.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconView.snp.right)
                .offset(18)
            make.right.equalTo(arrowView.snp.left)
                .offset(-50)
        }
        
        arrowView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.height.width.equalTo(32)
        }
    }
}

