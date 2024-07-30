//
//  PopularPresenter.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import Foundation

protocol PopularPresenterProtocol {
    init(view: PopularViewProtocol, router: Router)
}

final class PopularPresenter: PopularPresenterProtocol {
    // MARK: - Private Properties
    private weak var view: PopularViewProtocol?
    private let router: Router
    
    // MARK: - Init
    init(view: PopularViewProtocol, router: Router) {
        self.view = view
        self.router = router
    }
}
