//
//  EditProfilePresenter.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation
import FirebaseAuth

enum ReauthenticateMode {
    case email
    case password
}

protocol EditProfilePresenterProtocol {
    func saveUserData(user: UserApp)
    func fetchUser()
    func isLoginBooked(login: String) -> Bool
    func isEmailBooked(email: String) -> Bool
    func reathenticate(mode: ReauthenticateMode)
}

final class EditProfilePresenter: EditProfilePresenterProtocol {
    weak var view: EditProfileViewControllerProtocol?
    private var router: ProfileRouterProtocol
    private var currentUser: UserApp? {
        didSet {
            guard let currentUser else { return }
            view?.fetchUser(currentUser)
        }
    }
    
    init(view: EditProfileViewControllerProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func saveUserData(user: UserApp) {
        StorageManager.shared.saveUser(user)
        view?.updateRightBarButtonImage()
        if !user.login.isEmpty {
            AuthenticationManager.shared.updateUsername(name: user.login)
        }
    }
    
    func fetchUser() {
        let user = Auth.auth().currentUser
        guard let user else { return }
        currentUser = .init(id: user.uid, login: user.displayName ?? "Unknown", email: user.email ?? "-")
    }
    
    func isLoginBooked(login: String) -> Bool {
        
        return false
    }
    
    func isEmailBooked(email: String) -> Bool {
        
        return false
    }
    
    func reathenticate(mode: ReauthenticateMode) {
        router.showReauthenticate(mode: mode)
    }
}

