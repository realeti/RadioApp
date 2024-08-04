//
//  Router.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

//import UIKit
//
//class Router {
//    weak var controller: UIViewController?
//    
//    func pushScreen(_ vc: UIViewController) {
//        guard let controller else { return }
//        if let navController = controller.navigationController {
//            navController.pushViewController(vc, animated: true)
//        } else {
//            controller.present(vc, animated: true)
//        }
//    }
//}

import UIKit

class Router {
    weak var controller: UIViewController?
    
    func pushScreen(_ vc: UIViewController) {
        guard let controller else {
            return
        }
        if let navController = controller.navigationController {
            navController.pushViewController(vc, animated: true)
        } else {
            presentScreen(vc)
        }
    }
    
    func presentScreen(_ vc: UIViewController) {
        controller?.present(vc, animated: true)
    }
}
