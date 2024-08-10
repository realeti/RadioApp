//
//  Notification + Extensions.swift
//  RadioApp
//
//  Created by realeti on 08.08.2024.
//

import Foundation

extension Notification.Name {
    static let playerStatusDidChange = Notification.Name(K.Notification.playerStatusDidChange)
    static let playerCurrentIndexDidChange = Notification.Name(K.Notification.playerCurrentIndexDidChange)
    static let playerVolumeDidChange = Notification.Name(K.Notification.playerVolumeDidChange)
    static let favoriteRemoved = Notification.Name(K.Notification.favoriteRemoved)
}
