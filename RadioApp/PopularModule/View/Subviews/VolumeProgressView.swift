//
//  VolumeProgressView.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import UIKit

final class VolumeProgressView: UIView {
    // MARK: - UI
    private lazy var volumeLabel: UILabel = {
        let label = UILabel()
        label.text = "50%"
        label.textColor = .white
        label.font = .systemFont(ofSize: 10.0, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var progressBarContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var volumeProgressBar: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .martimeBlue
        view.progressTintColor = .neonBlueApp
        view.progress = 0.5
        return view
    }()
    
    private lazy var volumeImageView: UIImageView = {
        let view = UIImageView()
        view.image = .volume
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let progressCircleLayer = CAShapeLayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupProgressCircleLayer()
        
        updateProgressCirclePosition()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VolumeProgress Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        volumeProgressBar.transform = CGAffineTransform(rotationAngle: .pi / -2)
    }
    
    // MARK: - Set Views
    func setupUI() {
        addSubviews(progressBarContainer, volumeLabel, volumeImageView)
        progressBarContainer.addSubview(volumeProgressBar)
    }
    
    private func setupProgressCircleLayer() {
        let circleRadius: CGFloat = Metrics.circleRadius
        let circleSize: CGSize = CGSize(width: circleRadius * 2, height: circleRadius * 2)
        
        /// draw circle path
        let circlePath = UIBezierPath(
            arcCenter: .zero,
            radius: circleRadius,
            startAngle: 0,
            endAngle: .pi * 2,
            clockwise: true
        )
        circlePath.close()
        
        /// init path & color
        progressCircleLayer.path = circlePath.cgPath
        progressCircleLayer.fillColor = UIColor.neonBlueApp.cgColor
        
        /// add layer to progress bar container
        progressBarContainer.layer.addSublayer(progressCircleLayer)
    }

    private func setVolumeProgress(_ progress: Float) {
        UIView.animate(withDuration: 0.1) {
            self.volumeProgressBar.progress = progress
        }
        updateProgressCirclePosition()
    }
    
    private func updateProgressCirclePosition() {
        let progress = volumeProgressBar.progress
        let trackHeight = Metrics.progressBarHeight
        let trackCenter = Metrics.progressBarWidth / 2
        let xOffset = (Metrics.circleRadius / 2) - trackCenter
        let yOffset = trackHeight * CGFloat(progress)
        
        progressCircleLayer.position = CGPoint(x: xOffset, y: yOffset)
    }
}

// MARK: - Setup Constraints
private extension VolumeProgressView {
    func setupConstraints() {
        setupVolumeLabelConstraints()
        setupProgressBarContainerConstraints()
        setupVolumeProgressConstraints()
        setupVolumeImageViewConstraints()
    }
    
    func setupVolumeLabelConstraints() {
        volumeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(progressBarContainer.snp.top).offset(-9.5)
            make.width.equalTo(30.0)
        }
    }
    
    func setupProgressBarContainerConstraints() {
        progressBarContainer.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(Metrics.progressBarWidth)
            make.height.equalTo(Metrics.progressBarHeight)
        }
    }
    
    func setupVolumeProgressConstraints() {
        volumeProgressBar.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(progressBarContainer.snp.height)
            make.height.equalTo(progressBarContainer.snp.width)
        }
    }
    
    func setupVolumeImageViewConstraints() {
        volumeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(progressBarContainer.snp.bottom).offset(20.0)
            make.width.equalTo(18.0)
            make.height.equalTo(16.0)
        }
    }
}

// MARK: - Metrics
fileprivate struct Metrics {
    /// progress bar
    static let progressBarWidth: CGFloat = 3.0
    static let progressBarHeight: CGFloat = 200.0
    
    /// progress bar circle
    static let circleRadius: CGFloat = 5.0
}
