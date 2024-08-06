//
//  ProfilePresenter.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation

protocol ProfileViewProtocol: AnyObject {
  
}

protocol ProfilePresenterProtocol: AnyObject {
    func showEditProfileVC()
    func showPolicyVC()
    func showAboutUsVC()
    func showLanguageVC()
    init(router: ProfileRouterProtocol)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    private let router: ProfileRouterProtocol
    
    required init(router: ProfileRouterProtocol) {
        self.router = router
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
