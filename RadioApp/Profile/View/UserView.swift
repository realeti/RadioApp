//
//  UserView.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import UIKit

final class UserView: UIView {
    
    // MARK: - Closures
    var editButtonTap: (() -> Void)?
    
    // MARK: - Private UI Properties
    private lazy var profileImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = .mockPic
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        var label = UILabel.makeLabel(
            font: .systemFont(ofSize: 14, weight: .bold),
            color: .white,
            numberOfLines: 1,
            alignment: .left)
        label.text = "Mark"
        return label
    }()
    
    private lazy var userEmailLabel: UILabel = {
        var label = UILabel.makeLabel(
            font: .systemFont(ofSize: 14),
            color: .white,
            numberOfLines: 1,
            alignment: .left)
        label.text = "mark@gmail.com"
        return label
    }()
    
    private lazy var editButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(.edit, for: .normal)
        button.tintColor = .neonBlueApp
        let action = UIAction { _ in
            self.editButtonDidTapped()
        }
        button.addAction(action, for: .primaryActionTriggered)
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMainView()
        setViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    // MARK: - Public Methods
    func setViews(with user: User) {
        profileImageView.image = UIImage(data: user.image)
        userNameLabel.text = user.login
        userEmailLabel.text = user.email
    }
    
    // MARK: - Private Actions
     private func editButtonDidTapped() {
        editButtonTap?()
    }
}

// MARK: - Setup UI
private extension UserView {
    func setViews() {
        addSubviews(profileImageView, userNameLabel, userEmailLabel, editButton)
    }
    
    func setupMainView() {
        self.backgroundColor = .clear
        self.layer.borderColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
    }

    func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(12)
            make.left.equalToSuperview()
                .offset(16)
            make.bottom.equalToSuperview()
                .offset(-12)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .offset(21)
            make.left.equalTo(profileImageView.snp.right)
                .offset(16)
        }
        
        userEmailLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom)
                .offset(8)
            make.left.equalTo(profileImageView.snp.right)
                .offset(16)
            make.right.equalToSuperview()
                .offset(-16)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-18)
            make.width.height.equalTo(22)
        }
    }
}
