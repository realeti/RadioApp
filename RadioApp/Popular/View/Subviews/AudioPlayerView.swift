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
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
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
            make.edges.equalToSuperview()
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
    static let playerButtonWidth: CGFloat = 111.0
    static let playerButtonHeight: CGFloat = 122.0
    
    /// back button
    static let backButtonWidth: CGFloat = 42.0
    static let backButtonHeight: CGFloat = 46.0
    
    /// next button
    static let nextButtonWidth: CGFloat = 42.0
    static let nextButtonHeight: CGFloat = 46.0
    
    private init() {}
}
