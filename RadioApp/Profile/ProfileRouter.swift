//
//  ProfileRouter.swift
//  RadioApp
//
//  Created by Иван Семенов on 30.07.2024.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject, Router {
    func showPrivacyPolicy()
    func showEditProfile()
    func showLanguageVC()
    func showAboutUsVC()
    func showReauthenticate(mode: ReauthenticateMode)
}

final class ProfileRouter: Router, ProfileRouterProtocol {
    func showPrivacyPolicy() {
        let vc = Builder.createPrivacyPolicyVC()
        pushScreen(vc)
    }
    
    func showEditProfile() {
        let vc = Builder.createEditProfileVC()
        pushScreen(vc)
    }

    func showLanguageVC() {
        let vc = Builder.createLanguageVC()
        pushScreen(vc)
    }
    
    func showAboutUsVC() {
        let vc = Builder.createAboutUsVC()
        pushScreen(vc)
    }
    
    func showReauthenticate(mode: ReauthenticateMode) {
        let authorization = RootBuilder().buildAuthorization()
        authorization.reauthenticate(on: self, with: mode)
    }
}
