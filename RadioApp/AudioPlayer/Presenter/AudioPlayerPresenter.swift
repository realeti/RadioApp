//
//  AudioPlayerPresenter.swift
//  RadioApp
//
//  Created by realeti on 06.08.2024.
//

import Foundation

protocol AudioViewProtocol: AnyObject {
    func didTapPlayPauseButton()
    func didTapBackButton()
    func didTapNextButton()
    func didUpdatePlayerImage(_ isPlaying: Bool)
    func setupVolumeProgress()
}

protocol AudioPlayerPresenterProtocol {
    init(view: AudioViewProtocol)
    
    func playPauseAudio()
    func previousStation()
    func nextStation()
}

final class AudioPlayerPresenter: AudioPlayerPresenterProtocol {
    // MARK: - Private Properties
    private let audioPlayer = AudioPlayerController.shared
    private weak var view: AudioViewProtocol?
    
    // MARK: - Init
    init(view: AudioViewProtocol) {
        self.view = view
    }
}

// MARK: - Presenter Delegate methods
extension AudioPlayerPresenter {
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
}
