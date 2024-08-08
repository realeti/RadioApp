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
    
    init(view: EditProfileViewControllerProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
    }
    
    func saveUserData(user: UserApp) {

    }
    
    func fetchUser() {

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

