//
//  ProfileBuilder.swift
//  RadioApp
//
//  Created by Иван Семенов on 30.07.2024.
//

import UIKit

extension Builder {
    static func createPrivacyPolicyVC() -> UIViewController  {
        let view = PrivacyViewController()
        let presenter = PrivacyPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createEditProfileVC() -> UIViewController {
        let view = EditProfileViewController()
        let router = ProfileRouter()
        router.controller = view
        let presenter = EditProfilePresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }

    static func createLanguageVC() -> UIViewController {
        let view = LanguageViewController()
        let presenter = LanguagePresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createAboutUsVC() -> UIViewController {
        let view = AboutUsViewController()
        let presenter = AboutUsPresenter(view: view)
        view.presenter = presenter
        return view
    }
}
