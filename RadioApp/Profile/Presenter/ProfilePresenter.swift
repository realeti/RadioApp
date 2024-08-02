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
    func showNotificationVC()
    func showPolicyVC()
    func showAboutUsVC()
    func showLanguageVC()
    init(view: ProfileViewProtocol, router: ProfileRouterProtocol)
}

final class ProfilePresenter: ProfilePresenterProtocol {
    
    weak var view: ProfileViewProtocol?
    private var router: ProfileRouterProtocol?
    
    required init(view: ProfileViewProtocol, router: ProfileRouterProtocol) {
        self.view = view
        self.router = router
    }
   
    func showEditProfileVC() {
        router?.showEditProfile()
    }
    
    func showNotificationVC() {
        router?.showNotifications()
    }
    
    func showPolicyVC() {
        router?.showPrivacyPolicy()
    }
    
    func showAboutUsVC() {
        router?.showAboutUsVC()
    }
    
    func showLanguageVC() {
        router?.showLanguageVC()
    }
}
