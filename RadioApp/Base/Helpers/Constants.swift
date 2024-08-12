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
    static let audioPlayerWidth: CGFloat = 111.0
    static let audioPlayerHeight: CGFloat = 122.0
    static let audioPlayerBottomIndent: CGFloat = 104.0
    static let volumeContainerWidth: CGFloat = 14.0
    static let volumeContainerHeight: CGFloat = 200.0
    static let volumeContainerLeadingIndent: CGFloat = 16.0
    
    // MARK: - Notification & UserInfoKeys
    struct Notification {
        static let playerStatusDidChange = "PlayerStatusDidChange"
        static let playerStationDidChange = "PlayerStationDidChange"
        static let playerCurrentIndexDidChange = "PlayerCurrentIndexDidChange"
        static let playerVolumeDidChange = "PlayerVolumeDidChange"
        static let favoriteRemoved = "FavoriteRemoved"
    }

    struct UserInfoKey {
        static let isPlaying = "isPlaying"
        static let stationUUID = "stationUUID"
        static let stationIndex = "stationIndex"
        static let playerVolume = "playerVolume"
        static let removedStationIndex = "removedStationIndex"
    }
    
    private init() {}
}
