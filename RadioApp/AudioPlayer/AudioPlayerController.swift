//
//  AudioPlayerController.swift
//  RadioApp
//
//  Created by realeti on 04.08.2024.
//

import Foundation
import AVFoundation

protocol AudioPlayerProtocol {
	var currentUUID: UUID? { get }
    var currentIndex: Int { get }
    var isPlaying: Bool { get }
    
    func playPause()
    func playPrevious()
    func playNext()
    func playStation(at index: Int)
    func setStations(_ stations: [PlayerStation], startIndex: Int)
}

final class AudioPlayerController: AudioPlayerProtocol {
    // MARK: - Singleton Instance
    static let shared = AudioPlayerController()
    
    // MARK: - Private Properties
    private var audioPlayer: AVPlayer?
    private var stations: [PlayerStation] = []
    private var currentVolume: Float = 0.5
    
    // MARK: - Public Properties
	var currentUUID: UUID?
    
    var currentIndex: Int = 0 {
        didSet { currentUUID = stations[currentIndex].id }
    }
    
    var volume: Float {
        get { currentVolume }
        set {
            currentVolume = newValue
            audioPlayer?.volume = currentVolume
        }
    }
    
    var isPlaying: Bool = false
    
    private init() {}
}

// MARK: - AudioPlayer Methods
extension AudioPlayerController {
    private func playStream(url: URL) {
        stopStream()
        
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
        audioPlayer?.volume = currentVolume
        
        isPlaying = true
        postStatusNotification()
    }
    
    func playPause() {
        guard let audioPlayer else { return }
        
        if (isPlaying) {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
        
        isPlaying.toggle()
        postStatusNotification()
    }
    
    func playPrevious() {
        guard !stations.isEmpty else { return }
        
        currentIndex = (currentIndex - 1 + stations.count) % stations.count
        playStation(at: currentIndex)
    }
    
    func playNext() {
        guard !stations.isEmpty else { return }
        
        currentIndex = (currentIndex + 1) % stations.count
        playStation(at: currentIndex)
    }
    
    func playStation(at index: Int) {
        let station = stations[index]
        
        if let url = URL(string: station.url) {
            currentIndex = index
            playStream(url: url)
        }
    }
    
    func setStations(_ stations: [PlayerStation], startIndex: Int) {
        self.stations = stations
        currentIndex = startIndex
    }
}

// MARK: - AudioPlayer Stop Stream
private extension AudioPlayerController {
    func stopStream() {
        audioPlayer?.pause()
        audioPlayer = nil
        isPlaying = false
    }
}

// MARK: - AudioPlayer Notifications
private extension AudioPlayerController {
    func postStatusNotification() {
        NotificationCenter.default.post(
            name: .playerStatusDidChange,
            object: nil,
            userInfo: [K.UserInfoKey.isPlaying: isPlaying]
        )
        
        NotificationCenter.default.post(
            name: .playerCurrentIndexDidChange,
            object: nil,
            userInfo: [K.UserInfoKey.stationIndex: currentIndex]
        )
        
        guard let currentUUID else { return }
        
        NotificationCenter.default.post(
            name: .playerStationDidChange,
            object: nil,
            userInfo: [K.UserInfoKey.stationUUID: currentUUID]
        )
    }
}
