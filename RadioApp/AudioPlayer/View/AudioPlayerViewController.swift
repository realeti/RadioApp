//
//  AudioPlayerViewController.swift
//  RadioApp
//
//  Created by realeti on 06.08.2024.
//

import UIKit
import AVFAudio

final class AudioPlayerViewController: UIViewController {
    // MARK: - Private Properties
    private let presenter: AudioPlayerPresenterProtocol
    private var audioPlayerView: AudioPlayerView!
    
    // MARK: - Init
    init(presenter: AudioPlayerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        audioPlayerView = AudioPlayerView()
        view = audioPlayerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setVolumeValue()
        setNotification()
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        audioPlayerView.setDelegate(self)
    }
    
    // MARK: - Set Notification
    private func setNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handlePlayerStatusChange),
            name: .playerStatusDidChange,
            object: nil
        )
    }
    
    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Notification handle
private extension AudioPlayerViewController {
    @objc func handlePlayerStatusChange(_ notification: Notification) {
        if let isPlaying = notification.userInfo?[K.UserInfoKey.isPlaying] as? Bool {
            audioPlayerView.updatePlayerImage(isPlaying, animated: false)
        }
    }
}

// MARK: - AudioView Delegate Methods
extension AudioPlayerViewController: AudioPlayerViewProtocol {
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
        audioPlayerView.updatePlayerImage(isPlaying, animated: true)
    }
}

// MARK: - Set VolumeProgress
extension AudioPlayerViewController {
    func setVolumeValue() {
        let volume = getSystemVolume()
        audioPlayerView.updateVolume(volume)
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
