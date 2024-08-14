//
//  ProfilePresenter.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation
import FirebaseAuth

protocol ProfileViewProtocol: AnyObject {
    func update(with user: UserApp?)
}

protocol ProfilePresenterProtocol: AnyObject {
    var currentUser: UserApp? { get }
    func showEditProfileVC()
    func showPolicyVC()
    func showAboutUsVC()
    func showLanguageVC()
    func getCurrentUser()
    init(router: ProfileRouterProtocol)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    var currentUser: UserApp? {
        didSet {
            view?.update(with: currentUser)
        }
    }
    
    weak var view: ProfileViewProtocol?
    private let router: ProfileRouterProtocol
    
    required init(router: ProfileRouterProtocol) {
        self.router = router
    }
    
    func getCurrentUser() {
        let user = Auth.auth().currentUser
        guard let user else { return }
        currentUser = .init(id: user.uid, login: user.displayName ?? "Unknown", email: user.email ?? "")
    }
    
    func showEditProfileVC() {
        router.showEditProfile()
    }
    
    func showPolicyVC() {
        router.showPrivacyPolicy()
    }
    
    func showAboutUsVC() {
        router.showAboutUsVC()
    }
    
    func showLanguageVC() {
        router.showLanguageVC()
    }
}
