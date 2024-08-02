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

class ForgotPasswordController: UIViewController {
    var presenter: (any ForgotPasswordPresenterProtocol)?
    private var email: String?

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
        mainLabel.text = "Forgot\nPassword"
        
        let emailField = AuthorizationField(delegate: self, title: "Email", placeholder: "Your email", isSecure: false)
        
        let sendButton = UIButton()
        sendButton.setTitle("Send", for: .normal)
        sendButton.titleLabel?.font = .systemFont(ofSize: 28, weight: .light)
        sendButton.backgroundColor = .neonBlueApp
        sendButton.tintColor = .white
        sendButton.layer.cornerRadius = 8
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
            make.height.equalTo(62)
        }
    }
    
    
    @objc func backTapped() {
        print("back tapped")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func sendTapped() {
        print("send tapped")
        presenter?.requestUpdatePassword(email: email)
    }
}

extension ForgotPasswordController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        email = textField.text
        return true
    }
}

@available(iOS 17.0, *)
#Preview {
    Builder.createForgotPasswordVC()
}
