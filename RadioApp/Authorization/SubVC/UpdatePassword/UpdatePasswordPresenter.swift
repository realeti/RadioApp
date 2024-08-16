//
//  UpdatePasswordPresenter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 02.08.2024.
//

import UIKit

protocol UpdatePasswordPresenterProtocol {
    func activate()
    func updatePassword(password: String?, repeatedPassword: String?)
}

final class UpdatePasswordPresenter: UpdatePasswordPresenterProtocol {
    weak var view: UpdatePasswordController?
    private var router: AuthorizationRouterProtocol?
    
    init(view: UpdatePasswordController, router: AuthorizationRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func updatePassword(password: String?, repeatedPassword: String?) {
        guard let password, let repeatedPassword, !password.isEmpty, !repeatedPassword.isEmpty else {
            view?.showError(isAlert: true, title: "Some of the password fields are empty", message: "Please fill all the password fields", actionTitle: "Ok", action: { [weak self] _ in
                self?.view?.hideError()
            })
            return
        }
        
        guard password == repeatedPassword else {
            view?.showError(isAlert: true, title: "Passwords doesn't match", message: "Please fill check your password fields", actionTitle: "Ok", action: { [weak self] _ in
                self?.view?.hideError()
            })
            return
        }
        
        Task {
            do {
                let result = try await AuthenticationManager.shared.updatePassword(newPassword: password)
                if result {
                    print("password successfully updated")
                    let alertController =  await UIAlertController(title: "Password successfully updated".localized, message: nil, preferredStyle: .alert)
                    await alertController.addAction(UIAlertAction(title: "OK".localized, style: .default
                                                                  , handler: { _ in
                        //go back to edit profile
                        
                        self.router?.backToEditProfile()
                        
                    }))
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.present(alertController, animated: true, completion: nil)
                    }
                    
                    
                } else {
                    print("can't update password")
                }
            }
            catch {
                print(error.localizedDescription)
                await view?.showError(isAlert: true, title: "Can't update password", message: error.localizedDescription, actionTitle: "Try again", action: { _ in
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.hideError()
                    }
                })
            }
        }
    }
    
    func activate() {
        view?.update(with: .init())
    }
}
