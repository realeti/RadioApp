//
//  FavoritesProtocol.swift
//  RadioApp
//
//  Created by Natalia on 02.08.2024.
//

import Foundation

protocol FavoritesControllerProtocol: AnyObject {
    func update(with model: FavoritesController.Model)
}

protocol FavoritesPresenterProtocol {
    func activate()
}

protocol FavoritesRouterProtocol {
    func showDetails()
}
