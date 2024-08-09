//
//  AudioPlayerView.swift
//  RadioApp
//
//  Created by realeti on 04.08.2024.
//

import UIKit
import SnapKit

final class AudioPlayerView: UIView {
    // MARK: - UI
    private let playerStackView = UIStackView(
        axis: .horizontal,
        spacing: 24.0,
        distribution: .fill,
        alignment: .center
    )
    
    private let playerButton = UIButton(backgroundImage: .playerPlay)
    private let backButton = UIButton(backgroundImage: .playerBack)
    private let nextButton = UIButton(backgroundImage: .playerNext)
    
    private lazy var volumeContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let volumeSlider = VolumeSlider()
    
    private let volumeLabel = UILabel(
        font: .systemFont(ofSize: 10.0, weight: .regular),
        alignment: .center
    )
    
    private let volumeImageView = UIImageView(
        image: .volume,
        contentMode: .scaleAspectFit
    )
    
    // MARK: - Delegate
    weak var delegate: AudioViewProtocol?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupActions()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        volumeSlider.transform = CGAffineTransform(rotationAngle: .pi / -2)
    }
    
    // MARK: - Set Views
    private func setupUI() {
        addSubviews(
            playerStackView,
            volumeContainer,
            volumeLabel,
            volumeImageView
        )
        
        playerStackView.addArrangedSubviews(
            backButton,
            playerButton,
            nextButton
        )
        
        volumeContainer.addSubview(volumeSlider)
    }
}

// MARK: - External methods
extension AudioPlayerView {
    func updatePlayerImage(_ isPlaying: Bool, animated: Bool) {
        let playerImage: UIImage = isPlaying ? .playerPause : .playerPlay
        
        if animated {
            UIView.animate(withDuration: 0.1) {
                self.playerButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            } completion: { _ in
                self.playerButton.setBackgroundImage(playerImage, for: .normal)
                self.playerButton.setBackgroundImage(playerImage, for: .highlighted)
                
                UIView.animate(withDuration: 0.1, animations: {
                    self.playerButton.transform = .identity
                })
            }
        } else {
            playerButton.setBackgroundImage(playerImage, for: .normal)
            playerButton.setBackgroundImage(playerImage, for: .highlighted)
        }
    }
}

// MARK: - Setup Actions
private extension AudioPlayerView {
    func setupActions() {
        playerButton.addTarget(self, action: #selector(playerButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    // Actions
    @objc private func playerButtonTapped(_ sender: UIButton) {
        delegate?.didTapPlayPauseButton()
    }
    
    @objc private func backButtonTapped(_ sender: UIButton) {
        delegate?.didTapBackButton()
    }
    
    @objc private func nextButtonTapped(_ sender: UIButton) {
        delegate?.didTapNextButton()
    }
}

// MARK: - Setup Constraints
private extension AudioPlayerView {
    func setupConstraints() {
        setupPlayerStackViewConstraints()
        setupPlayerButtonConstraints()
        setupBackButtonConstraints()
        setupNextButtonConstraints()
        setupVolumeContainerConstraints()
        setupVolumeSliderConstraints()
        setupVolumeLabelConstraints()
        setupVolumeImageViewConstraints()
    }
    
    func setupPlayerStackViewConstraints() {
        playerStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupPlayerButtonConstraints() {
        playerButton.snp.makeConstraints { make in
            make.width.equalTo(K.audioPlayerWidth)
            make.height.equalTo(K.audioPlayerHeight)
        }
    }
    
    func setupBackButtonConstraints() {
        backButton.snp.makeConstraints { make in
            make.width.equalTo(Metrics.backButtonWidth)
            make.height.equalTo(Metrics.backButtonHeight)
        }
    }
    
    func setupNextButtonConstraints() {
        nextButton.snp.makeConstraints { make in
            make.width.equalTo(Metrics.nextButtonWidth)
            make.height.equalTo(Metrics.nextButtonHeight)
        }
    }
    
    func setupVolumeContainerConstraints() {
        volumeContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(25.0)
            make.width.equalTo(Metrics.volumeSliderWidth)
            make.height.equalTo(Metrics.volumeSliderHeight)
        }
    }
    
    func setupVolumeSliderConstraints() {
        volumeSlider.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(volumeContainer.snp.height)
            make.height.equalTo(volumeContainer.snp.width)
        }
    }
    
    func setupVolumeLabelConstraints() {
        volumeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(volumeContainer.snp.centerX)
            make.bottom.equalTo(volumeContainer.snp.top).offset(-Metrics.volumeLabelBottomOffset)
            make.width.equalTo(Metrics.volumeLabelWidth)
        }
    }
    
    func setupVolumeImageViewConstraints() {
        volumeImageView.snp.makeConstraints { make in
            make.centerX.equalTo(volumeContainer.snp.centerX)
            make.top.equalTo(volumeContainer.snp.bottom).offset(Metrics.volumeImageTopOffset)
            make.width.equalTo(Metrics.volumeImageWidth)
            make.height.equalTo(Metrics.volumeImageHeight)
        }
    }
}

fileprivate struct Metrics {
    /// back button
    static let backButtonWidth: CGFloat = 42.0
    static let backButtonHeight: CGFloat = 46.0
    
    /// next button
    static let nextButtonWidth: CGFloat = 42.0
    static let nextButtonHeight: CGFloat = 46.0
    
    /// volume slider
    static let volumeSliderWidth: CGFloat = 3.0
    static let volumeSliderHeight: CGFloat = 200.0
    
    /// volume  label
    static let volumeLabelWidth: CGFloat = 30.0
    static let volumeLabelBottomOffset: CGFloat = 9.5
    
    /// volume image
    static let volumeImageTopOffset: CGFloat = 20.0
    static let volumeImageWidth: CGFloat = 18.0
    static let volumeImageHeight: CGFloat = 16.0
    
    private init() {}
}
