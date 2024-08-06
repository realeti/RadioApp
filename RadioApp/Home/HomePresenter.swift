//
//  HomePresenter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 06.08.2024.
//

import UIKit

final class HomePresenter {
    weak var view: HomeController?
    private let router: HomeRouter
    
    init(router: HomeRouter) {
        self.router = router
    }
}
