//
//  ProfileRouter.swift
//  RadioApp
//
//  Created by Иван Семенов on 30.07.2024.
//

import UIKit

protocol ProfileRouterProtocol: AnyObject {
    func showPrivacyPolicy()
    func showEditProfile()
    func showNotifications()
    func showLanguageVC()
    func showAboutUsVC()

}
final class ProfileRouter: Router, ProfileRouterProtocol {
    func showPrivacyPolicy() {
        let vc = Builder.createPrivacyPolicyVC()
        vc.hidesBottomBarWhenPushed = true
        pushScreen(vc)
    }
    
    func showEditProfile() {
        let vc = Builder.createEditProfileVC()
        vc.hidesBottomBarWhenPushed = true
        pushScreen(vc)
    }
        
    func showNotifications() {
        let vc = Builder.createNotificationsVC()
        vc.hidesBottomBarWhenPushed = true
        pushScreen(vc)
    }
    func showLanguageVC() {
        let vc = NavigationController(rootViewController: Builder.createLanguageVC())
        vc.modalPresentationStyle = .fullScreen
        presentScreen(vc)
    }
    func showAboutUsVC() {
        let vc = Builder.createAboutUsVC()
        vc.hidesBottomBarWhenPushed = true
        pushScreen(vc)
    }
}
