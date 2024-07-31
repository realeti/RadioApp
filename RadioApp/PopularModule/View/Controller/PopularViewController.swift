//
//  PopularViewController.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit
import MediaPlayer
import AVFoundation

protocol PopularViewProtocol: AnyObject {
    
}

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
        
        setDelegates()
        setupVolumeProgress()
        //observeVolumeChanges()
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        popularView.radioCollectionViewDataSource = self
        popularView.radioCollectionViewDelegate = self
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
        print("jereqq")
        if let volume = notification.userInfo?["AVSystemController_AudioVolumeNotificationParameter"] as? Float {
            popularView.updateVolumeProgress(volume)
            print("jere")
        }
    }*/
}

// MARK: - RadioCollectionView DataSource methods
extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.popularRadioCell, for: indexPath) as? PopularCollectionViewCell else {
            return UICollectionViewCell()
        }
        //cell.configure(with: )
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
