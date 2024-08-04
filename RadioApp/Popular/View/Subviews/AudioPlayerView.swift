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
            make.width.height.equalTo(Metrics.playerButtonSize)
        }
    }
    
    func setupBackButtonConstraints() {
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(Metrics.backButtonSize)
        }
    }
    
    func setupNextButtonConstraints() {
        nextButton.snp.makeConstraints { make in
            make.width.height.equalTo(Metrics.nextButtonSize)
        }
    }
}

fileprivate struct Metrics {
    /// player button
    static let playerButtonSize: CGFloat = 127.0
    
    /// back button
    static let backButtonSize: CGFloat = 48.0
    
    /// next button
    static let nextButtonSize: CGFloat = 48.0
    
    private init() {}
}
