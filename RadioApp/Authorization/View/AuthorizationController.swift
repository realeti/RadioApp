//
//  AuthorizationController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit
import SnapKit

class AuthorizationController: UIViewController {
    var presenter: (any AuthorizationPresenterProtocol)?
    private var mode: AuthorizationMode?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.activate()
    }
}

extension AuthorizationController: AuthorizationControllerProtocol {
    struct Model {
        var mode: AuthorizationMode
    }
    
    func update(with model: Model) {
        mode = model.mode
        view = UIView()
        switch model.mode {
        case .signIn:
            setupCommonUI(with: configureSignInUI())
        case .signUp:
            setupCommonUI(with: configureSignUpUI())
        }
    }
}

//UI Common
private extension AuthorizationController {
    func setupCommonUI(with stack: UIView) {
        guard let mode else { return }
        
        let bg = UIImageView(image: .bgNontransparent)
        bg.contentMode = .scaleAspectFill
        
        let icon = UIImageView(image: .iconNoBg)
        icon.contentMode = .scaleAspectFit
        
        let mainLabel = UILabel()
        mainLabel.font = .systemFont(ofSize: 50, weight: .bold)
        mainLabel.textColor = .white
        
        let startPlayLabel = UILabel()
        startPlayLabel.font = .systemFont(ofSize: 25, weight: .regular)
        startPlayLabel.textColor = .white
        startPlayLabel.text = "to start play"
        
        let doneButton = UIButton()
        doneButton.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        doneButton.backgroundColor = .neonBlueApp
        doneButton.tintColor = .white
        doneButton.layer.cornerRadius = 8
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        
        let switchModeButton = UIButton()
        switchModeButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .light)
        switchModeButton.titleLabel?.textColor = .white
        switchModeButton.addTarget(self, action: #selector(switchModeTapped), for: .touchUpInside)
        
        switch mode {
        case .signIn:
            mainLabel.text = "Sign in"
            switchModeButton.setTitle("Or Sign Up", for: .normal)
        case .signUp:
            mainLabel.text = "Sign Up"
            switchModeButton.setTitle("Or Sign In", for: .normal)
        }

        view.addSubview(bg)
        view.addSubview(icon)
        view.addSubview(mainLabel)
        view.addSubview(startPlayLabel)
        view.addSubview(stack)
        view.addSubview(doneButton)
        view.addSubview(switchModeButton)
        
 
        bg.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        icon.snp.makeConstraints { make in
            make.width.height.equalTo(58)
            make.top.equalToSuperview().inset(112)
            make.leading.equalToSuperview().inset(43)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon)
            make.top.equalTo(icon.snp.bottom).inset(-35)
        }
        
        startPlayLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainLabel)
            make.top.equalTo(mainLabel.snp.bottom)
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(startPlayLabel.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(43)
        }
        
        doneButton.snp.makeConstraints { make in
            make.leading.equalTo(stack)
            make.top.equalTo(stack.snp.bottom).inset(-43)
            make.width.equalTo(152)
            make.height.equalTo(62)
        }
        
        switchModeButton.snp.makeConstraints { make in
            make.leading.equalTo(doneButton).inset(5)
            make.top.equalTo(doneButton.snp.bottom).inset(-6)
        }
    }
    
    @objc func doneTapped() {
        print("done tapped")
        presenter?.finishAuthorization()
    }
    
    @objc func switchModeTapped() {
        print("switch mode tapped")
        presenter?.switchMode()
    }
}

//UI SignIn
private extension AuthorizationController {
    func configureSignInUI() -> UIView {
        let container = UIView()
        let stack = UIStackView()
        let emailField = AuthorizationField(delegate: self, title: "Email", placeholder: "Your email", isSecure: false)
        let passwordField = AuthorizationField(delegate: self, title: "Password", placeholder: "Your password", isSecure: true)
        
        let forgotPasswordButton = UIButton()
        forgotPasswordButton.setTitle("Forgot Password ?", for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        forgotPasswordButton.titleLabel?.textColor = .white
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        
        let line1 = UIView()
        line1.backgroundColor = .gray
        let line2 = UIView()
        line2.backgroundColor = .gray
        
        let googleLabel = UILabel()
        googleLabel.font = .systemFont(ofSize: 11, weight: .bold)
        googleLabel.textColor = .gray
        googleLabel.text = "Or connect with"
        
        let googleButton = UIButton()
        googleButton.setImage(.googlePlus, for: .normal)
        googleButton.addTarget(self, action: #selector(googleTapped), for: .touchUpInside)
        
        stack.addArrangedSubview(emailField)
        stack.addArrangedSubview(passwordField)
        stack.axis = .vertical
        stack.spacing = 17
        
        container.addSubview(stack)
        container.addSubview(forgotPasswordButton)
        container.addSubview(googleLabel)
        container.addSubview(line1)
        container.addSubview(line2)
        container.addSubview(googleButton)
        
        stack.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).inset(-10)
            make.trailing.equalToSuperview()
        }
        
        googleLabel.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).inset(-20)
            make.centerX.equalToSuperview()
        }
        
        line1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.centerY.equalTo(googleLabel)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalTo(googleLabel.snp.leading).inset(-16)
        }
        
        line2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.centerY.equalTo(googleLabel)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(googleLabel.snp.trailing).inset(-16)
        }
        
        googleButton.snp.makeConstraints { make in
            make.top.equalTo(googleLabel.snp.bottom).inset(-20)
            make.height.width.equalTo(40)
            make.centerX.bottom.equalToSuperview()
        }
        
        return container
    }
    
    @objc func forgotPasswordTapped() {
        print("forgot password tapped")
        presenter?.didTapForgotPasswordButton()
    }
    
    @objc func googleTapped() {
        print("google tapped")
        presenter?.didTapGoogleButton()
    }
}


//UI SignUp
private extension AuthorizationController {
    func configureSignUpUI() -> UIView {
        let container = UIView()
        let stack = UIStackView()
        let nameField = AuthorizationField(delegate: self, title: "Name", placeholder: "Your name", isSecure: false)
        let emailField = AuthorizationField(delegate: self, title: "Email", placeholder: "Your email", isSecure: false)
        let passwordField = AuthorizationField(delegate: self, title: "Password", placeholder: "Your password", isSecure: true)
        
        stack.addArrangedSubview(nameField)
        stack.addArrangedSubview(emailField)
        stack.addArrangedSubview(passwordField)
        stack.axis = .vertical
        stack.spacing = 17

        container.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        return container
    }
}

extension AuthorizationController: UITextFieldDelegate {
    
}

@available(iOS 17.0, *)
#Preview {
    Builder.createAuthorization()
}
