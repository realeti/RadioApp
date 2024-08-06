//
//  HomeRouter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 06.08.2024.
//

import UIKit

final class HomeRouter {
    private let builder: HomeAssembly
    weak var root: RootRouter?
    
    init(builder: HomeAssembly) {
        self.builder = builder
    }
    
    func showHome(on window: UIWindow) {
        window.rootViewController = builder.build(router: self)
    }
}
