//
//  HomeTabBar.swift
//  RadioApp
//
//  Created by realeti on 07.08.2024.
//

import UIKit

final class HomeTabBar: UITabBar {
    // MARK: - UI
    private var audioPlayerView: AudioPlayerView?
    
    // MARK: - Init
    init(frame: CGRect, audioPlayerView: AudioPlayerView) {
        super.init(frame: frame)
        self.audioPlayerView = audioPlayerView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
