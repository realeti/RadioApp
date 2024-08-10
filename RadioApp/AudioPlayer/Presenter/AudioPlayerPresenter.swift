//
//  AudioPlayerPresenter.swift
//  RadioApp
//
//  Created by realeti on 06.08.2024.
//

import Foundation

protocol AudioPlayerViewProtocol: AnyObject {
    func didTapPlayPauseButton()
    func didTapBackButton()
    func didTapNextButton()
    func didUpdatePlayerImage(_ isPlaying: Bool)
}

protocol VolumePlayerProtocol: AnyObject {
    func updatePlayerVolume(_ volume: Float)
}

protocol AudioPlayerPresenterProtocol {
    func playPauseAudio()
    func previousStation()
    func nextStation()
    func getPlayerVolume() -> Float
    func updatePlayerVolume(_ volume: Float)
}

final class AudioPlayerPresenter: AudioPlayerPresenterProtocol {
    // MARK: - Private Properties
    private let audioPlayer = AudioPlayerController.shared
    
    // MARK: - Public Properties
    weak var view: AudioPlayerViewProtocol?
    
    // MARK: - AudioPlayer Methods
    func playPauseAudio() {
        audioPlayer.playPause()
        
        let isPlaying = audioPlayer.isPlaying
        view?.didUpdatePlayerImage(isPlaying)
    }
    
    func previousStation() {
        audioPlayer.playPrevious()
    }
    
    func nextStation() {
        audioPlayer.playNext()
    }
    
    func getPlayerVolume() -> Float {
        audioPlayer.volume
    }
    
    func updatePlayerVolume(_ volume: Float) {
        audioPlayer.volume = volume
    }
}
