//
//  Builder.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit

final class Builder {
    
    static func createTabBar() -> UIViewController {
        TabBarController()
    }
    
    static func createAuthorization() -> UIViewController {
        AuthorizationAssembly().build()
    }
    
//    static func createPopular() -> UIViewController {
//       
//    }
//    
    static func createFavorite() -> UIViewController {
        FavoritesAssembly().build(router: FavoritesRouter())
    }
//    
//    static func createSearch() -> UIViewController {
//        
//    }
//    
//    static func createProfile() -> UIViewController {
//        
//    }
//    
    static func createOnboarding() -> UIViewController {
        OnboardingAssembly().build()
    }
}
