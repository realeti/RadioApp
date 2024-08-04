//
//  CustomTabBar.swift
//  RadioApp
//
//  Created by realeti on 04.08.2024.
//

import UIKit

final class CustomTabBar: UITabBar {
    // MARK: - UI
    private let audioPlayerView = AudioPlayerView()
    
    // MARK: - Public Properties
    weak var tabBarController: UITabBarController?
    
    // MARK: - Private Properties
    private let audioPlayer = AudioPlayerController.shared
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setDelegates()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Views
    private func setupUI() {
        addSubview(audioPlayerView)
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        audioPlayerView.delegate = self
    }
}

// MARK: - Setup Constraints
private extension CustomTabBar {
    func setupConstraints() {
        setupAudioPlayerViewConstraints()
    }
    
    func setupAudioPlayerViewConstraints() {
        audioPlayerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(snp.top).inset(11.5)
        }
    }
}

// MARK: - AudioPlayerView Delegate methods
extension CustomTabBar: AudioPlayerViewDelegate {
    func didTapPlayPauseButton() {
        audioPlayer.playPause()
        
        let isPlaying = audioPlayer.isPlaying
        audioPlayerView.updatePlayerButtonImage(isPlaying)
    }
    
    func didTapBackButton() {
        audioPlayer.playPrevious()
    }
    
    func didTapNextButton() {
        audioPlayer.playNext()
    }
}

// MARK: - Hit test
extension CustomTabBar {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        /// if UITabBar is hidden
        guard !isHidden else {
            return super.hitTest(point, with: event)
        }
        
        /// convert coordinate points to audioPlayerView
        let pointInAudioPlayerView = audioPlayerView.convert(point, from: self)
        
        /// if point inside audioPlayerView
        if audioPlayerView.point(inside: pointInAudioPlayerView, with: event) {
            /// find and return audioPlayerView subview
            return audioPlayerView.hitTest(pointInAudioPlayerView, with: event)
        }
        
        /// return event to other UITabBar subviews
        return super.hitTest(point, with: event)
    }
}
