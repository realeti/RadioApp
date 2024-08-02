//
//  FavoritesModel.swift
//  RadioApp
//
//  Created by Natalia on 02.08.2024.
//

import Foundation

struct FavoritesModel {
    let radioTitle: String
    let genre: String
    let favoriteHandler: () -> Void
    let didSelectHandler: () -> Void
}
