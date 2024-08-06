//
//  AudioPlayerViewController.swift
//  RadioApp
//
//  Created by realeti on 06.08.2024.
//

import UIKit
import AVFAudio

final class AudioPlayerViewController: UIViewController {
    // MARK: - Public Properties
    var presenter: AudioPlayerPresenterProtocol!
    
    // MARK: - Private Properties
    private var audioView: AudioView!
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        audioView = AudioView()
        view = audioView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setupVolumeProgress()
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        audioView.setDelegates(self)
    }
}

// MARK: - AudioView Delegate methods
extension AudioPlayerViewController: AudioViewProtocol {
    func didTapPlayPauseButton() {
        presenter.playPauseAudio()
    }
    
    func didTapBackButton() {
        presenter.previousStation()
    }
    
    func didTapNextButton() {
        presenter.nextStation()
    }
    
    func didUpdatePlayerImage(_ isPlaying: Bool) {
        audioView.updatePlayerImage(isPlaying)
    }
}

// MARK: - Set VolumeProgress
extension AudioPlayerViewController {
    func setupVolumeProgress() {
        let volume = getSystemVolume()
        audioView.updateVolume(volume)
    }
    
    private func getSystemVolume() -> Float {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setActive(true)
            return audioSession.outputVolume
        } catch {
            print("Error activating audio session: \(error)")
            return 0
        }
    }
}
