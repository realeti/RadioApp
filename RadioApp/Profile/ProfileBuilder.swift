//
//  ProfileBuilder.swift
//  RadioApp
//
//  Created by Иван Семенов on 30.07.2024.
//

import UIKit

extension Builder {
    static func createPrivacyPolicyVC() -> ViewController  {
        let view = PrivacyViewController(nibName: nil, bundle: nil)
        let presenter = PrivacyPresenter(view: view)
        view.presenter = presenter
        configureViewForTabBar(view)
        return view
    }
    
    static func createEditProfileVC() -> ViewController {
        let view = EditProfileViewController()
        let router = ProfileRouter()
        router.controller = view
        let presenter = EditProfilePresenter(view: view, router: router)
        view.presenter = presenter
        configureViewForTabBar(view)
        return view
    }

    static func createLanguageVC() -> ViewController {
        let view = LanguageViewController()
        let presenter = LanguagePresenter(view: view)
        view.presenter = presenter
        configureViewForTabBar(view)
        return view
    }
    
    static func createAboutUsVC() -> ViewController {
        let view = AboutUsViewController()
        let presenter = AboutUsPresenter(view: view)
        view.presenter = presenter
        configureViewForTabBar(view)
        return view
    }
    
    static func configureViewForTabBar(_ view: ViewController) {
        view.playerIsHidden = true
    }
}
