//
//  ForgotPasswordController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 01.08.2024.
//

import UIKit
import SnapKit

protocol ForgotPasswordControllerProtocol: AnyObject {
    func update(with model: ForgotPasswordController.Model)
}

final class ForgotPasswordController: UIViewController {
    var presenter: (any ForgotPasswordPresenterProtocol)?
    private var email: String?
    private var emailField: AuthorizationField?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.activate()
    }
}

extension ForgotPasswordController: ForgotPasswordControllerProtocol {
    struct Model {
        var email: String?
    }
    
    func update(with model: Model) {
        email = model.email
        setupUI()
    }
}

//UI
private extension ForgotPasswordController {
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
        mainLabel.text = "Forgot\nPassword".localized
        
        let emailField = AuthorizationField(delegate: self, title: "Email".localized, placeholder: "Your email".localized, isSecure: false)
        guard let emailField else { return }
        emailField.textField.text = email
        
        let sendButton = UIButton()
        sendButton.setTitle("Send".localized, for: .normal)
        sendButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        sendButton.backgroundColor = .neonBlueApp
        sendButton.tintColor = .white
        sendButton.layer.cornerRadius = 10
        sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        
        view.addSubview(bg)
        view.addSubview(backButton)
        view.addSubview(mainLabel)
        view.addSubview(emailField)
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
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(43)
        }
        
        sendButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(emailField)
            make.top.equalTo(emailField.snp.bottom).inset(-70)
            make.height.equalTo(58)
        }
    }
    
    
    @objc func backTapped() {
        print("back tapped")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sendTapped() {
        print("send tapped")
        presenter?.requestUpdatePassword(email: emailField?.textField.text)
    }
}

extension ForgotPasswordController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
