//
//  AudioPlayerController.swift
//  RadioApp
//
//  Created by realeti on 04.08.2024.
//

import Foundation
import AVFoundation

protocol AudioPlayerProtocol {
	var playingStationUUID: UUID? { get }
    var currentIndex: Int { get }
    var isPlaying: Bool { get }
    var volume: Float { get set }
    
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
	var playingStationUUID: UUID?
    
    var currentIndex: Int = 0 {
        didSet {
            if currentIndex >= 0, currentIndex < stations.count {
                playingStationUUID = stations[currentIndex].id
            }
        }
    }
    
    var isPlaying: Bool = false {
        didSet { postStatusNotification() }
    }
    
    var volume: Float {
        get { currentVolume }
        set {
            currentVolume = newValue
            audioPlayer?.volume = currentVolume
        }
    }
    
    private init() {}
}

// MARK: - Methods
extension AudioPlayerController {
    /// play & pause button action
    func playPause() {
        guard let audioPlayer else {
            playStation(at: currentIndex)
            return
        }
        
        if (isPlaying) {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
        
        isPlaying.toggle()
    }
    
    /// previous button action
    func playPrevious() {
        guard !stations.isEmpty else { return }
        
        currentIndex = (currentIndex - 1 + stations.count) % stations.count
        playStation(at: currentIndex)
    }
    
    /// next button action
    func playNext() {
        guard !stations.isEmpty else { return }
        
        currentIndex = (currentIndex + 1) % stations.count
        playStation(at: currentIndex)
    }
    
    /// play selected station
    func playStation(at index: Int) {
        let station = stations[index]
        
        if let url = URL(string: station.url) {
            currentIndex = index
            playStream(url: url)
        }
    }
    
    /// setup & play audio player
    private func playStream(url: URL) {
        stopStream()
        
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
        audioPlayer?.volume = currentVolume
        
        isPlaying = true
        postChangeNotification()
    }
}

// MARK: - Set Stations
extension AudioPlayerController {
    func setStations(_ stations: [PlayerStation], startIndex: Int) {
        self.stations = stations
        currentIndex = startIndex
    }
}

// MARK: - Stop Stream
private extension AudioPlayerController {
    func stopStream() {
        audioPlayer?.pause()
        audioPlayer = nil
        isPlaying = false
    }
}

// MARK: - Notifications
private extension AudioPlayerController {
    func postStatusNotification() {
        NotificationCenter.default.post(
            name: .playerStatusDidChange,
            object: nil,
            userInfo: [K.UserInfoKey.isPlaying: isPlaying] 
        )
    }
    
    func postChangeNotification() {
        guard let playingStationUUID else { return }
        
        NotificationCenter.default.post(
            name: .playerStationDidChange,
            object: nil,
            userInfo: [K.UserInfoKey.stationUUID: playingStationUUID]
        )
    }
}
