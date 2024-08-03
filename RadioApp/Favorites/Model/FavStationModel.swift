//
//  FavoritesModel.swift
//  RadioApp
//
//  Created by Natalia on 02.08.2024.
//

import Foundation

struct FavStationModel: Equatable {
    let radioTitle: String
    let genre: String
    let favoriteHandler: () -> Void
    let didSelectHandler: () -> Void
    
    static func == (lhs: FavStationModel, rhs: FavStationModel) -> Bool {
        return lhs.radioTitle == rhs.radioTitle && lhs.genre == rhs.genre
    }
}
