//
//  Builder.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit

final class Builder {
    
    static func createTabBar() -> UIViewController {
        return UIViewController()
    }
    
    static func createPopular() -> UIViewController {
        PopularAssembly().build()
    }
    
    static func createFavorite() -> UIViewController {
        return UIViewController()
    }
    
    static func createSearch() -> UIViewController {
        return UIViewController()
    }
    
    static func createProfile() -> UIViewController {
        return UIViewController()
    }
    
    static func createOnboarding() -> UIViewController {
        return UIViewController()
    }
}
