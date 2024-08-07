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
    
    // MARK: - Set Views
    private func setupUI() {
        addSubview(playerStackView)
        
        playerStackView.addArrangedSubviews(
            backButton,
            playerButton,
            nextButton
        )
    }
}

// MARK: - External methods
extension AudioPlayerView {
    func updatePlayerImage(_ isPlaying: Bool) {
        let playerImage: UIImage = isPlaying ? .playerPause : .playerPlay
        
        UIView.animate(withDuration: 0.1) {
            self.playerButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            self.playerButton.setBackgroundImage(playerImage, for: .normal)
            self.playerButton.setBackgroundImage(playerImage, for: .highlighted)
            
            UIView.animate(withDuration: 0.1, animations: {
                self.playerButton.transform = .identity
            })
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
    }
    
    func setupPlayerStackViewConstraints() {
        playerStackView.snp.makeConstraints { make in
            //make.edges.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupPlayerButtonConstraints() {
        playerButton.snp.makeConstraints { make in
            make.width.equalTo(Metrics.playerButtonWidth)
            make.height.equalTo(Metrics.playerButtonHeight)
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
}

fileprivate struct Metrics {
    /// player button
    static let playerButtonWidth: CGFloat = K.audioPlayerWidth
    static let playerButtonHeight: CGFloat = K.audioPlayerHeight
    
    /// back button
    static let backButtonWidth: CGFloat = 42.0
    static let backButtonHeight: CGFloat = 46.0
    
    /// next button
    static let nextButtonWidth: CGFloat = 42.0
    static let nextButtonHeight: CGFloat = 46.0
    
    private init() {}
}
