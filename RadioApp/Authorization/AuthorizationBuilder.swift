//
//  AuthorizationBuilder.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

extension Builder {
    static func createForgotPasswordVC(router: AuthorizationRouterProtocol? = nil) -> UIViewController  {
        let view = ForgotPasswordController()
        let presenter = ForgotPasswordPresenter(view: view, router: router ?? AuthorizationRouter())
        view.presenter = presenter
        return view
    }
    
    static func createUpdatePasswordVC(router: AuthorizationRouterProtocol? = nil) -> UIViewController  {
        let view = UpdatePasswordController()
        let presenter = UpdatePasswordPresenter(view: view, router: router ?? AuthorizationRouter())
        view.presenter = presenter
        return view
    }
}
