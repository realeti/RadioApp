//
//  AudioView.swift
//  RadioApp
//
//  Created by realeti on 06.08.2024.
//

import UIKit
import SnapKit

final class AudioView: UIView {
    // MARK: - UI
    private let audioPlayerView = AudioPlayerView()
    //private let audioVolumeView = AudioVolumeView()
    
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
        addSubviews(audioPlayerView/*, audioVolumeView*/)
    }
}

// MARK: - External methods
extension AudioView {
    func updateVolume(_ volume: Float) {
        //audioVolumeView.update(volume)
    }
    
    func updatePlayerImage(_ isPlaying: Bool) {
        audioPlayerView.updatePlayerImage(isPlaying)
    }
}

// MARK: - Set Delegates
extension AudioView {
    func setDelegates(_ delegate: AudioViewProtocol) {
        audioPlayerView.delegate = delegate
    }
}

// MARK: - Setup Constraints
private extension AudioView {
    func setupConstraints() {
        setupAudioPlayerViewConstraints()
        //setupAudioVolumeViewConstraints()
    }
    
    func setupAudioPlayerViewConstraints() {
        audioPlayerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(Metrics.audioPlayerBottomIndent)
        }
    }
    
    /*func setupAudioVolumeViewConstraints() {
        audioVolumeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Metrics.audioVolumeLeadingIndent)
        }
    }*/
}

fileprivate struct Metrics {
    /// audio player view
    static let audioPlayerBottomIndent: CGFloat = 11.5
    
    /// audio player volume view
    //static let audioVolumeLeadingIndent: CGFloat = 25.0
    
    private init() {}
}
