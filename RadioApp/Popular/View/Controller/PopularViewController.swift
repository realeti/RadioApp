//
//  PopularViewController.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit
import AVFoundation

final class PopularViewController: ViewController {
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
    }
    
    // MARK: - Load Stations
    private func loadStations() {
        Task {
            await presenter.loadStations()
        }
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        popularView.radioCollection.dataSource = self
        popularView.radioCollection.delegate = self
    }
}

// MARK: - Set VolumeProgress
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

// MARK: - PopularView Delegate methods
extension PopularViewController: PopularViewProtocol {
    func didUpdateStations() {
        DispatchQueue.main.async {
            self.popularView.radioCollection.reloadData()
        }
    }
    
    /*func didUpdateVotedStation() {
        DispatchQueue.main.async {
            self.popularView.radioCollection.reloadData()
        }
    }*/
    
    func voteForStation(at indexPath: IndexPath?, stationUniqueID: UUID?) {
        guard let indexPath, let stationUniqueID else { return }
        
        let stationId = indexPath.row
        presenter.toggleVoteState(for: stationId, stationUniqueID: stationUniqueID)
        
        let isStationVoted = presenter.isStationVoted(stationId)
        updateStationVotes(at: indexPath, isStationVoted)
    }
    
    private func updateStationVotes(at indexPath: IndexPath, _ isStationVoted: Bool) {
        guard let cell = popularView.radioCollection.cellForItem(at: indexPath) as? PopularCollectionViewCell else {
            return
        }
        cell.updateStationVotes(isStationVoted)
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
        let isStationVoted = presenter.isStationVoted(indexPath.row)
        
        cell.delegate = self
        cell.configure(with: stationData, isStationVoted, and: indexPath)
        return cell
    }
}

// MARK: - RadioCollectionView Delegate methods
extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let stationId = indexPath.row
        presenter.changeStation(stationId)
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
