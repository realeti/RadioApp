//
//  AudioPlayerViewController.swift
//  RadioApp
//
//  Created by realeti on 06.08.2024.
//

import UIKit

final class AudioPlayerViewController: UIViewController {
    // MARK: - Private Properties
    private let presenter: AudioPlayerPresenterProtocol
    private var audioView: AudioPlayerView!
    
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
        
        audioView = AudioPlayerView()
        view = audioView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setNotification()
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        audioView.delegate = self
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
        if let isPlaying = notification.userInfo?["isPlaying"] as? Bool {
            audioView.updatePlayerImage(isPlaying, animated: false)
        }
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
        audioView.updatePlayerImage(isPlaying, animated: true)
    }
}
