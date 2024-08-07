//
//  Constants.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import Foundation

struct K {
    // MARK: - Popular Module
    enum Popular: String {
        case title = "Popular"
        case votes = "votes"
    }
    
    // MARK: - Reusable Cells
    static let popularRadioCell = "popularCell"
    
    // MARK: - Audio Player
    static let audioPlayerHeight: CGFloat = 122.0
    static let audioPlayerWidth: CGFloat = 111.0
    static let audioPlayerBottomIndent: CGFloat = 11.5
    
    private init() {}
}
