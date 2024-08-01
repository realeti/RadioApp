//
//  AuthorizationField.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

class AuthorizationField: UIView {
    private let title: String
    private let placeholder: String
    private var isSecure: Bool
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    
    init(delegate: (any UITextFieldDelegate)?, title: String, placeholder: String, isSecure: Bool) {
        self.title = title
        self.placeholder = placeholder
        self.isSecure = isSecure
        super.init(frame: .zero)
        textField.delegate = delegate
        configure()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .white
        titleLabel.text = title
        
        textField.font = .systemFont(ofSize: 16, weight: .light)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.layer.borderColor = UIColor.pinkApp.cgColor
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 5
        textField.layer.shadowColor = UIColor.pinkApp.cgColor
        textField.layer.shadowRadius = 5
        textField.layer.shadowOpacity = 1
        if isSecure {
            textField.rightView = getEyeButton()
            textField.rightViewMode = .always
            textField.isSecureTextEntry = true
            textField.setLeftPaddingPoints(16)
        } else {
            textField.setLeftPaddingPoints(16)
            textField.setRightPaddingPoints(16)
        }
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(textField)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-15)
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(52)
        }
    }
    
    private func getEyeButton() -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let eyeButton = UIButton(frame: CGRect(x: 0, y: 10, width: 20, height: 20))
        if isSecure {
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
        eyeButton.imageView?.contentMode = .scaleAspectFit
        eyeButton.tintColor = .gray
        eyeButton.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
        container.addSubview(eyeButton)
        
        return container
    }
    
    @objc private func eyeTapped() {
        isSecure.toggle()
        textField.rightView = getEyeButton()
        textField.isSecureTextEntry.toggle()
    }
}
