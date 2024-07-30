//
//  ExampleRouter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit

final class ExampleRouter: Router, ExampleRouterProtocol {
    func showExampleVC2() {
        let vc = Builder.createExampleVC2()
        pushScreen(vc)
    }
    
    func showExampleVC3() {
        let vc = Builder.createExampleVC3()
        pushScreen(vc)
    }
}
