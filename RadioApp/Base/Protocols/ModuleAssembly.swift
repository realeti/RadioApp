//
//  ModuleAssembly.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit

protocol ModuleAssembly {
    associatedtype Router

    func build(router: Router) -> UIViewController
}
