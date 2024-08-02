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

class UpdatePasswordController: UIViewController {
    var presenter: (any UpdatePasswordPresenterProtocol)?
    private var password: String?

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
        password = model.password
        setupUI()
    }
}

//UI
private extension UpdatePasswordController {
    func setupUI() {
        
        let bg = UIImageView(image: .bgNontransparent)
        bg.contentMode = .scaleAspectFill
        
        let backButton = UIButton()
        backButton.setImage(.backButton.withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        let mainLabel = UILabel()
        mainLabel.font = .systemFont(ofSize: 50, weight: .bold)
        mainLabel.textColor = .white
        mainLabel.numberOfLines = 2
        mainLabel.text = "Update\nPassword"
        
        let passwordField = AuthorizationField(delegate: self, title: "Password", placeholder: "Your password", isSecure: true)
        
        let confirmPasswordField = AuthorizationField(delegate: self, title: "Confirm password", placeholder: "Your password", isSecure: true)
        
        let sendButton = UIButton()
        sendButton.setTitle("Change password", for: .normal)
        sendButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        sendButton.backgroundColor = .neonBlueApp
        sendButton.tintColor = .white
        sendButton.layer.cornerRadius = 10
        sendButton.addTarget(self, action: #selector(changePasswordTapped), for: .touchUpInside)
        
        view.addSubview(bg)
        view.addSubview(backButton)
        view.addSubview(mainLabel)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(sendButton)
 
        bg.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(27)
            make.top.equalToSuperview().inset(112)
            make.leading.equalToSuperview().inset(43)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(backButton)
            make.top.equalTo(backButton.snp.bottom).inset(-35)
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
    
    
    @objc func backTapped() {
        print("back tapped")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func changePasswordTapped() {
        print("change password tapped")
        presenter?.updatePassword(password: password)
    }
}

extension UpdatePasswordController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        password = textField.text
        return true
    }
}

@available(iOS 17.0, *)
#Preview {
    Builder.createUpdatePasswordVC()
}
