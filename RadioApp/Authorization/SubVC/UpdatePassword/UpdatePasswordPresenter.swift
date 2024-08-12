//
//  UpdatePasswordPresenter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 02.08.2024.
//

import UIKit

protocol UpdatePasswordPresenterProtocol {
    func activate()
    func updatePassword(password: String?)
}

final class UpdatePasswordPresenter: UpdatePasswordPresenterProtocol {
    weak var view: UpdatePasswordController?
    private var router: AuthorizationRouterProtocol?
    
    init(view: UpdatePasswordController, router: AuthorizationRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func updatePassword(password: String?) {
        guard let password else { return }
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
            }
        }
    }
    
    func activate() {
        view?.update(with: .init())
    }
}
