//
//  ForgotPasswordPresenter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 01.08.2024.
//

import Foundation
import UIKit

enum ForgotMode {
    case forgotPassword
    case updateEmail
}

protocol ForgotPasswordPresenterProtocol {
    func activate()
    func requestUpdatePassword(email: String?)
    func requestUpdateEmail(email: String?)
}

final class ForgotPasswordPresenter: ForgotPasswordPresenterProtocol {
    weak var view: ForgotPasswordController?
    private var router: AuthorizationRouterProtocol?
    private let mode: ForgotMode
    
    init(view: ForgotPasswordController, router: AuthorizationRouterProtocol, mode: ForgotMode) {
        self.view = view
        self.router = router
        self.mode = mode
    }
    
    func requestUpdatePassword(email: String?) {
        guard let email else {
            print("No email found!")
            return
        }
        
        guard !email.isEmpty else {
            print("No email found!")
            return
        }
        
        Task {
            do {
                try await AuthenticationManager.shared.resetPassword(with: email)
                print("successfuly send request on email")
                DispatchQueue.main.async { [weak self] in
                    let ac = UIAlertController(title: "Sent request on email", message: "Do you want to open browser in app to navigate to mail client or you'll do it on your own?", preferredStyle: .alert)
                    let browserAction = UIAlertAction(title: "Open Browser", style: .default) { [weak self] _ in
                        let browser = BrowserController() { self?.router?.proceedToSignIn() }
                        self?.view?.present(browser, animated: true)
                        }
                    let returnAction = UIAlertAction(title: "Return to Sign In", style: .default) { [weak self] _ in
                        self?.router?.proceedToSignIn()
                    }

                    ac.addAction(browserAction)
                    ac.addAction(returnAction)

                    self?.view?.present(ac, animated: true)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        
    }
    
    func requestUpdateEmail(email: String?) {
        guard let email else {
            print("No email found!")
            return
        }
        
        guard !email.isEmpty else {
            print("No email found!")
            return
        }
        
        Task {
            do {
                try await AuthenticationManager.shared.updateEmail(newEmail: email)
                print("successfuly send request on email")
                DispatchQueue.main.async { [weak self] in
                    let ac = UIAlertController(title: "Sent request on email", message: "You need to open browser in app to navigate to mail client to confirm email update", preferredStyle: .alert)
                    let browserAction = UIAlertAction(title: "Open Browser", style: .default) { [weak self] _ in
                        let browser = BrowserController() { self?.router?.backToEditProfile() }
                        self?.view?.present(browser, animated: true)
                        }

                    ac.addAction(browserAction)

                    self?.view?.present(ac, animated: true)
                }
            } catch {
                print("Error: \(error)")
            }
        }
        
    }
    
    func activate() {
        view?.update(with: .init(mode: mode))
    }
}
