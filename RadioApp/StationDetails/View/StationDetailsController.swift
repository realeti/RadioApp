//
//  StationDetailsController.swift
//  RadioApp
//
//  Created by Alexander on 5.08.24.
//

import UIKit
import Kingfisher
import RadioBrowser

protocol StationDetailsView: AnyObject {
    func displayStationDetails(_ station: RadioStation)
    func startEqualizerAnimation()
    func stopEqualizerAnimation()
}

final class StationDetailsController: ViewController {
    
    //MARK: - Private properties
    
    private let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bg_nontransparent")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let radioFrequencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    private let radioNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.white
        return label
    }()
    
    private let stationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favOff"), for: .normal)
        button.setImage(UIImage(named: "favOn"), for: .selected)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let radioBrowser = RadioBrowser.default
    
    private let equalizerView = EqualizerView()
    
    private lazy var volumeView = HorizontalVolumeView()
    
    var presenter: StationDetailsPresenterProtocol!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setVolumeValue()
    }
    
    private func setupUI() {
        title = "Playing now"
        
        addSubviews()
        setDelegates()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        view.addSubview(radioFrequencyLabel)
        view.addSubview(radioNameLabel)
        view.addSubview(stationImageView)
        view.addSubview(equalizerView)
        view.addSubview(favoriteButton)
        view.addSubview(volumeView)
    }
    
    private func setDelegates() {
        volumeView.delegate = self
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        radioFrequencyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview().offset(-20)
        }
        
        radioNameLabel.snp.makeConstraints { make in
            make.top.equalTo(radioFrequencyLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview().offset(-20)
        }
        
        equalizerView.snp.makeConstraints { make in
            make.top.equalTo(radioNameLabel.snp.bottom).inset(-30)
            make.leading.trailing.equalToSuperview()
        }
        
        stationImageView.snp.makeConstraints { make in
            make.top.equalTo(radioFrequencyLabel.snp.top)
            make.trailing.equalToSuperview().offset(-30)
//            make.leading.equalTo(radioNameLabel.snp.trailing).offset(10)
            make.height.width.equalTo(50)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.bottom.equalTo(stationImageView.snp.top).offset(-20)
            make.trailing.equalTo(stationImageView.snp.trailing)
            make.height.width.equalTo(20)
        }
        
        volumeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(K.volumeContainerHeight)
            make.height.equalTo(K.volumeContainerWidth)
        }
    }
    
    @objc private func favoriteButtonTapped() {
        favoriteButton.isSelected.toggle()
        
        if favoriteButton.isSelected {
            presenter.addStationToFavorites()
        } else {
            presenter.removeStationFromFavorites()
        }
    }
}

// MARK: - Set Volume Value
extension StationDetailsController {
    func setVolumeValue() {
        let volume = presenter.getPlayerVolume()
        
        volumeView.update(volume)
    }
}

// MARK: - Update Player Volume
extension StationDetailsController: VolumePlayerProtocol {
    func updatePlayerVolume(_ volume: Float) {
        presenter.updatePlayerVolume(volume)
        postVolumeChangeNotification(volume)
    }
    
    private func postVolumeChangeNotification(_ volume: Float) {
        NotificationCenter.default.post(
            name: .playerVolumeDidChange,
            object: nil,
            userInfo: [K.UserInfoKey.playerVolume: volume]
        )
    }
}

//MARK: - StationDetailsView

extension StationDetailsController: StationDetailsView {
    
    func displayStationDetails(_ station: RadioStation) {
        
        let placeholderImage = UIImage(named: "googlePlus")

        if let imageUrlString = station.imageName, let imageUrl = URL(string: imageUrlString) {
               stationImageView.kf.setImage(with: imageUrl, placeholder: placeholderImage)
           } else {
               stationImageView.image = placeholderImage
           }
       
//        stationImageView.image = UIImage(named: "\(station.imageName)")
        radioFrequencyLabel.text = "\(station.frequency)"
        radioNameLabel.text = station.name
    }
    
    func startEqualizerAnimation() {
        equalizerView.startAnimating()
    }
    
    func stopEqualizerAnimation() {
        equalizerView.stopAnimating()
    }
}

