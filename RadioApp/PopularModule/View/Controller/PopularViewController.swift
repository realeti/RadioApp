//
//  PopularViewController.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit
//import MediaPlayer
import AVFoundation

final class PopularViewController: ViewController, PopularViewProtocol {
    // MARK: - Public Properties
    var presenter: PopularPresenterProtocol!
    
    // MARK: - Private Properties
    private var popularView: PopularView!
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        popularView = PopularView()
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadStations()
        setDelegates()
        setupVolumeProgress()
        //observeVolumeChanges()
    }
    
    // MARK: - Load Stations
    private func loadStations() {
        presenter.loadStations()
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        popularView.radioCollection.dataSource = self
        popularView.radioCollection.delegate = self
    }
}

// MARK: - Popular Delegate methods
extension PopularViewController {
    func didUpdateStations() {
        DispatchQueue.main.async {
            self.popularView.radioCollection.reloadData()
        }
    }
    
    func voteForStation(at indexPath: IndexPath?) {
        guard let indexPath else { return }
        
        let stationId = indexPath.row
        presenter.toggleVoteState(at: stationId)
        
        let isStationVoted = presenter.isStationVoted(at: stationId)
        updateStationVotes(at: indexPath, isStationVoted)
    }
    
    private func updateStationVotes(at indexPath: IndexPath, _ isStationVoted: Bool) {
        guard let cell = popularView.radioCollection.cellForItem(at: indexPath) as? PopularCollectionViewCell else {
            return
        }
        cell.updateStationVotes(isStationVoted)
    }
}

// MARK: - Setup VolumeProgress
private extension PopularViewController {
    func setupVolumeProgress() {
        let volume = getSystemVolume()
        popularView.updateVolumeProgress(volume)
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

// MARK: - RadioCollectionView DataSource methods
extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let stationsCount = presenter.getStations.count
        return stationsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: K.popularRadioCell,
            for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let stationData = presenter.getStations[indexPath.row]
        let isStationVoted = presenter.isStationVoted(at: indexPath.row)
        
        cell.delegate = self
        cell.configure(with: stationData, isStationVoted, and: indexPath)
        return cell
    }
}

// MARK: - RadioCollectionView Delegate methods
extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("row #\(indexPath.row)")
    }
}

// MARK: - RadioCollectionView FlowLayout Delegate methods
extension PopularViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 15.0
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing = (numberOfItemsPerRow - 1) * interItemSpacing
        let itemSize = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        return CGSize(width: itemSize, height: itemSize)
    }
}

// MARK: - Observe VolumeChanges
/*private extension PopularViewController {
    func observeVolumeChanges() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(volumeChanged),
            name: NSNotification.Name(rawValue: "SystemVolumeDidChange"),
            object: nil
        )
    }
}*/

// MARK: - Actions
private extension PopularViewController {
    /*@objc private func volumeChanged(notification: Notification) {
        if let volume = notification.userInfo?["AVSystemController_AudioVolumeNotificationParameter"] as? Float {
            popularView.updateVolumeProgress(volume)
        }
    }*/
}
