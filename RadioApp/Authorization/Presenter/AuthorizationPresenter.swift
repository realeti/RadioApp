//
//  AuthorizationPresenter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import Foundation
import UIKit

final class AuthorizationPresenter: AuthorizationPresenterProtocol {
    
    weak var view: AuthorizationControllerProtocol?
    private let router: AuthorizationRouterProtocol
    private var mode: AuthorizationMode
    
    init(mode: AuthorizationMode, router: AuthorizationRouterProtocol) {
        self.mode = mode
        self.router = router
    }

    func activate() {
        view?.update(with: .init(mode: mode))
    }
    
    func switchMode() {
        switch mode {
        case .signIn:
            mode = .signUp
        case .signUp:
            mode = .signIn
        case .reauthenticateEmail, .reauthenticatePassword:
            break
        }
        view?.update(with: .init(mode: mode))
    }
        
    func signIn(email: String?, password: String?) {
        guard let email, let password, !email.isEmpty, !password.isEmpty else {
            print("No email or password found!")
            return
        }
        
        Task {
            do {
                let data = try await AuthenticationManager.shared.signInUser(email: email, password: password)
                guard let userEmail = data.email else { return }
                print("successfuly signed in")
                DispatchQueue.main.async { [weak self] in
                    switch self?.mode {
                    case .signIn:
                        self?.router.goHome()
                    case .reauthenticatePassword:
                        self?.router.showUpdatePasswordVC()
                    case .reauthenticateEmail:
                        self?.router.showUpdateEmailVC()
                    default:
                        break
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                await view?.showError(title: "Can't sign in", message: error.localizedDescription, actionTitle: "Try again", action: { _ in
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.update(with: .init(mode: self?.mode ?? .signIn))
                        self?.view?.hideError()
                    }
                })
            }
        }
    }
    
    func signUp(name: String?, email: String?, password: String?) {
        guard let name, let email, let password else {
            print("No name, email or password found!")
            return
        }
        
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            print("No name, email or password found!")
            return
        }
        
        Task {
            do {
                let data = try await AuthenticationManager.shared.createUser(name: name, email: email, password: password)
                guard let userEmail = data.email else { return }
                print("successfuly signed up")
                AuthenticationManager.shared.updateUsername(name: name)
                DispatchQueue.main.async { [weak self] in
                    self?.router.goHome()
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func didTapGoogleButton() {
        Task {
            let result = await AuthenticationManager.shared.signInWithGoogleAccount()
            switch result {
            case true:
                DispatchQueue.main.sync { [weak self] in
                    self?.router.goHome()
                }
                
            case false:
                let ac = await UIAlertController(title: "Something went wrong", message: nil, preferredStyle: .alert)
                let submitAction = await UIAlertAction(title: "OK", style: .default)
                await ac.addAction(submitAction)

                let viewa = self.view as? UIViewController
                await viewa?.present(ac, animated: true)
            }
        }
    }
    
    func didTapForgotPasswordButton() {
        router.showForgotPasswordVC()
    }
}
