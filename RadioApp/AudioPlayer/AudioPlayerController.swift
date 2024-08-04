//
//  AudioPlayerController.swift
//  RadioApp
//
//  Created by realeti on 04.08.2024.
//

import Foundation
import AVFoundation

protocol AudioPlayerProtocol {
    func playPause()
    func playPrevious()
    func playNext()
}

final class AudioPlayerController {
    // MARK: - Singleton Instance
    static let shared = AudioPlayerController()
    
    // MARK: - Public Properties
    var isPlaying: Bool = false
    
    private init() {}
}

// MARK: - AudioPlayer methods
extension AudioPlayerController: AudioPlayerProtocol {
    func playPause() {
        isPlaying.toggle()
        print("Play/Pause button pressed")
    }
    
    func playPrevious() {
        print("Previous button pressed")
    }
    
    func playNext() {
        print("Next button pressed")
    }
}
