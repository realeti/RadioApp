//
//  ProfilePresenter.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation

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
            DispatchQueue.main.sync { [weak self] in
                self?.view?.update(with: self?.currentUser)
            }
        }
    }
    weak var view: ProfileViewProtocol?
    private let router: ProfileRouterProtocol
    
    required init(router: ProfileRouterProtocol) {
        self.router = router
    }
    
    func getCurrentUser() {
        Task {
            do {
                let user = try await AuthenticationManager.shared.getAuthenticatedUser()
                currentUser = .init(login: user.name ?? "Unknown", email: user.email ?? "-")
            }
            catch {
                print(error.localizedDescription)
            }
        }
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
