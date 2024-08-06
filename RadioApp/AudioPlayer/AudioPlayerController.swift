//
//  AudioPlayerController.swift
//  RadioApp
//
//  Created by realeti on 04.08.2024.
//

import Foundation
import AVFoundation

protocol AudioPlayerProtocol {
    func playStream(url: URL)
    func playPause()
    func playPrevious()
    func playNext()
}

final class AudioPlayerController: AudioPlayerProtocol {
    // MARK: - Singleton Instance
    static let shared = AudioPlayerController()
    
    // MARK: - Private properties
    private var audioPlayer: AVPlayer?
    
    // MARK: - Public Properties
    var currentURL: URL?
    var isPlaying: Bool = false
    
    private init() {}
}

// MARK: - AudioPlayer methods
extension AudioPlayerController {
    func playStream(url: URL) {
        stopStream()
        
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
        
        currentURL = url
        isPlaying = true
    }
    
    func playPause() {
        if (isPlaying) {
            audioPlayer?.pause()
        } else {
            audioPlayer?.play()
        }
        
        isPlaying.toggle()
    }
    
    func playPrevious() {
        print("Previous button pressed")
    }
    
    func playNext() {
        print("Next button pressed")
    }
}

// MARK: - AudioPlayer Stop Stream
private extension AudioPlayerController {
    func stopStream() {
        audioPlayer?.pause()
        audioPlayer = nil
        isPlaying = false
        currentURL = nil
    }
}
