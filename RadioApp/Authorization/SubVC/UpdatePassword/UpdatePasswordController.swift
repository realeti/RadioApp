//
//  UpdatePasswordController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 02.08.2024.
//

import UIKit
import SnapKit

protocol UpdatePasswordControllerProtocol: AnyObject {
    func update(with model: UpdatePasswordController.Model)
}

final class UpdatePasswordController: UIViewController {
    var presenter: (any UpdatePasswordPresenterProtocol)?
    private var passwordField: AuthorizationField?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.activate()
    }
}

extension UpdatePasswordController: UpdatePasswordControllerProtocol {
    struct Model {
        var password: String?
    }
    
    func update(with model: Model) {
        passwordField?.textField.text = model.password
        setupUI()
    }
}

//UI
private extension UpdatePasswordController {
    func setupUI() {
        let bg = UIImageView(image: .bgNontransparent)
        bg.contentMode = .scaleAspectFill
        
        let mainLabel = UILabel()
        mainLabel.font = .systemFont(ofSize: 50, weight: .bold)
        mainLabel.textColor = .white
        mainLabel.numberOfLines = 2
        mainLabel.text = "Update\nPassword".localized
        
        passwordField = AuthorizationField(delegate: self, title: "Password".localized, placeholder: "Your password".localized, isSecure: true)
        
        let confirmPasswordField = AuthorizationField(delegate: self, title: "Confirm password".localized, placeholder: "Your password".localized, isSecure: true)
        
        let sendButton = UIButton()
        sendButton.setTitle("Update password".localized, for: .normal)
        sendButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        sendButton.backgroundColor = .neonBlueApp
        sendButton.tintColor = .white
        sendButton.layer.cornerRadius = 10
        sendButton.addTarget(self, action: #selector(changePasswordTapped), for: .touchUpInside)
        
        guard let passwordField else { return }
        
        view.addSubview(bg)
        view.addSubview(mainLabel)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(sendButton)
 
        bg.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(43)
            make.top.equalToSuperview().inset(140)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(43)
        }
        
        confirmPasswordField.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).inset(-17)
            make.leading.trailing.equalToSuperview().inset(43)
        }
        
        sendButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(confirmPasswordField)
            make.top.equalTo(confirmPasswordField.snp.bottom).inset(-44)
            make.height.equalTo(58)
        }
    }
    
    @objc func changePasswordTapped() {
        print("change password tapped")
        presenter?.updatePassword(password: passwordField?.textField.text)
    }
}

extension UpdatePasswordController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
