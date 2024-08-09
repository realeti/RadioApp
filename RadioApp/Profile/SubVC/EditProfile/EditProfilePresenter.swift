//
//  EditProfilePresenter.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation

protocol EditProfilePresenterProtocol {
    func saveUserData(user: UserApp)
    func fetchUser()
    func isLoginBooked(login: String) -> Bool
    func isEmailBooked(email: String) -> Bool
    func reathenticate()
}

final class EditProfilePresenter: EditProfilePresenterProtocol {
    weak var view: EditProfileViewControllerProtocol?
    private var router: ProfileRouterProtocol
    private var currentUser: UserApp? {
        didSet {
            guard let currentUser else { return }
            DispatchQueue.main.sync { [weak self] in
                self?.view?.fetchUser(currentUser)
            }
        }
    }
    
    init(view: EditProfileViewControllerProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func saveUserData(user: UserApp) {
        if !user.login.isEmpty {
            AuthenticationManager.shared.updateUsername(name: user.login)
        }
        if !user.email.isEmpty {
        }
    }
    
    func fetchUser() {
        Task {
            do {
                let authUser = try await AuthenticationManager.shared.getAuthenticatedUser()
                currentUser = .init(login: authUser.name ?? "Unknown", email: authUser.email ?? "-")
                fetchUser()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func isLoginBooked(login: String) -> Bool {

        return false
    }
    
    func isEmailBooked(email: String) -> Bool {

        return false
    }
    
    func reathenticate() {
        router.showReauthenticate()
    }
    
    
}

