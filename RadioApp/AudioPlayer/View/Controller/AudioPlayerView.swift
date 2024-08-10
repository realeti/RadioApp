//
//  AudioPlayerView.swift
//  RadioApp
//
//  Created by realeti on 10.08.2024.
//

import UIKit
import SnapKit

final class AudioPlayerView: UIView {
    // MARK: - UI
    private let playerView = PlayerView()
    private let volumeView = VolumeView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Set Views
    private func setupUI() {
        addSubviews(playerView, volumeView)
    }
    
    // MARK: - Hit Test
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !isHidden else {
            return nil
        }
        
        let interactiveAreas = [playerView, volumeView]
        for area in interactiveAreas {
            let convertedPoint = area.convert(point, from: self)
            
            if area.bounds.contains(convertedPoint) {
                return area.hitTest(convertedPoint, with: event)
            }
        }
        return nil
    }
}

// MARK: - External Methods
extension AudioPlayerView {
    func setDelegate(_ delegate: AudioPlayerViewProtocol) {
        playerView.delegate = delegate
        volumeView.delegate = delegate
    }
    
    func updatePlayerImage(_ isPlaying: Bool, animated: Bool) {
        playerView.updatePlayerImage(isPlaying, animated: animated)
    }
    
    func updateVolume(_ volume: Float) {
        volumeView.update(volume)
    }
}

// MARK: - Setup Constraints
private extension AudioPlayerView {
    func setupConstraints() {
        setupPlayerViewConstraints()
        setupVolumeViewConstraints()
    }
    
    func setupPlayerViewConstraints() {
        playerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(K.audioPlayerBottomIndent)
            make.height.equalTo(K.audioPlayerHeight)
            make.width.equalToSuperview()
        }
    }
    
    func setupVolumeViewConstraints() {
        volumeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(K.volumeContainerLeadingIndent)
            make.width.equalTo(K.volumeContainerWidth)
            make.height.equalTo(K.volumeContainerHeight)
        }
    }
}
