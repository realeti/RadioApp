//
//  PopularViewController.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit

final class PopularViewController: ViewController {
    // MARK: - Private Properties
    private let presenter: PopularPresenterProtocol
    private var popularView: PopularView!
    
    // MARK: - Init
    init(presenter: PopularPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        popularView = PopularView()
        view = popularView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        setTapGesutre()
        setNotification()
        loadStations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !presenter.isLoadingData {
            presenter.setPlayerStations()
        }
    }
    
    // MARK: - Set Delegates
    private func setDelegates() {
        popularView.radioCollection.dataSource = self
        popularView.radioCollection.delegate = self
    }
    
    // MARK: - Set Tap Gesture
    private func setTapGesutre() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleDoubleTap)
        )
        tapGesture.numberOfTapsRequired = 2
        popularView.radioCollection.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Load Stations
    private func loadStations() {
        presenter.loadStations()
    }
    
    // MARK: - Deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Set Notifications
private extension PopularViewController {
    func setNotification() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleStationChange),
            name: .playerStationDidChange,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleFavoritesChanged),
            name: .favoriteRemoved,
            object: nil
        )
    }
}

// MARK: - Actions
private extension PopularViewController {
    /// Double tap on Item
    @objc func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        let collectionView = popularView.radioCollection
        let point = gesture.location(in: collectionView)
        
        if let indexPath = collectionView.indexPathForItem(at: point) {
            let stationId = indexPath.row
            presenter.showDetail(stationId)
        }
    }
    
    /// Station did change
    @objc func handleStationChange(_ notification: Notification) {
        guard let stationUUID = notification.userInfo?[K.UserInfoKey.stationUUID] as? UUID,
              let stationId = presenter.getStations.firstIndex(where: { $0.id == stationUUID })
        else {
            deselectItem(for: presenter.lastStationId)
            presenter.resetLastStationId()
            return
        }
        
        let indexPath = IndexPath(item: stationId, section: 0)
        popularView.radioCollection.selectItem(
            at: indexPath,
            animated: true,
            scrollPosition: .centeredVertically
        )
        presenter.updateLastStationId(stationId)
    }
    
    // view <- viewController <- presenter
    
    /// Station add or remove from Favorites
    @objc func handleFavoritesChanged(_ notification: Notification) {
        guard let stationUUID = notification.userInfo?[K.UserInfoKey.removedStationIndex] as? UUID,
              let stationId = presenter.getStations.firstIndex(where: { $0.id == stationUUID }),
              let cell = getCollectionViewCell(for: stationId) else {
            return
        }
        #warning("unclear responsibility")
        cell.clearVoteImage()
        presenter.removeVoteStatus(stationId)
    }
}

// MARK: - Get CollectionView Cell
private extension PopularViewController {
    func getCollectionViewCell(for stationId: Int) -> PopularCollectionViewCell? {
        let indexPath = IndexPath(item: stationId, section: 0)
        
        guard let cell = popularView.radioCollection.cellForItem(at: indexPath) as? PopularCollectionViewCell else {
            return nil
        }
        
        return cell
    }
}

// MARK: - Deselect CollectionView Cell
private extension PopularViewController {
    func deselectItem(for stationId: Int) {
        guard stationId != K.invalidStationId else {
            return
        }
        
        let indexPath = IndexPath(item: stationId, section: 0)
        popularView.radioCollection.deselectItem(at: indexPath, animated: false)
    }
}

// MARK: - PopularView Delegate methods
extension PopularViewController: PopularViewProtocol {
    func didUpdateStations() {
        popularView.radioCollection.reloadData()
    }
    
    func insertStations(at indexPaths: [IndexPath]) {
        popularView.radioCollection.performBatchUpdates({
            popularView.radioCollection.insertItems(at: indexPaths)
        }, completion: nil)
    }
    
    func voteForStation(at indexPath: IndexPath?) {
        guard let indexPath else { return }
        
        let stationId = indexPath.row
        presenter.toggleVoteState(for: stationId)
        
        let isStationVoted = presenter.isStationVoted(stationId)
        updateStationVotes(at: indexPath, isStationVoted)
    }
    
    #warning("verbose naming")
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
        #warning("verbose implementation")
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        /// check offset
        guard offsetY > 0 else { return }
        
        /// update collection when 20% until the end
        if offsetY > contentHeight - height * 1.2 {
            guard !presenter.isLoadingData else { return }
            presenter.loadStations()
        }
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
