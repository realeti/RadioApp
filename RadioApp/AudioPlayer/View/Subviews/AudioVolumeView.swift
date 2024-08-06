//
//  AudioVolumeView.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import UIKit

final class AudioVolumeView: UIView {
    // MARK: - UI
    private let volumeLabel = UILabel(
        font: .systemFont(ofSize: 10.0, weight: .regular),
        alignment: .center
    )
    
    private lazy var progressBarContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var volumeProgressBar: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .martimeBlue
        view.progressTintColor = .neonBlueApp
        return view
    }()
    
    private let volumeImageView = UIImageView(
        image: .volume,
        contentMode: .scaleAspectFit
    )
    
    private let progressCircleLayer = CAShapeLayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupProgressCircleLayer()
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
}

// MARK: - Setup ProgressCircle
private extension AudioVolumeView {
    func setupProgressCircleLayer() {
        let circleRadius: CGFloat = Metrics.circleRadius
        
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
}

// MARK: - Update Progress
extension AudioVolumeView {
    func update(_ volume: Float) {
        self.volumeProgressBar.progress = volume
        self.updateProgressCirclePosition()
        
        let progressValue = String(format: "%.0f", volume * 100.0)
        volumeLabel.text = progressValue + "%"
    }
    
    private func updateProgressCirclePosition() {
        let progress = volumeProgressBar.progress
        let trackHeight = Metrics.progressBarHeight
        let trackCenter = Metrics.progressBarWidth / 2
        let xOffset = (Metrics.circleRadius / 2) - trackCenter
        let yOffset = trackHeight - (trackHeight * CGFloat(progress))
        progressCircleLayer.position = CGPoint(x: xOffset, y: yOffset)
    }
}

// MARK: - Setup Constraints
private extension AudioVolumeView {
    func setupConstraints() {
        setupVolumeLabelConstraints()
        setupProgressBarContainerConstraints()
        setupVolumeProgressConstraints()
        setupVolumeImageViewConstraints()
    }
    
    func setupVolumeLabelConstraints() {
        volumeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(progressBarContainer.snp.top).offset(-Metrics.volumeLabelBottomOffset)
            make.width.equalTo(Metrics.volumeLabelWidth)
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
            make.top.equalTo(progressBarContainer.snp.bottom).offset(Metrics.volumeImageTopOffset)
            make.width.equalTo(Metrics.volumeImageWidth)
            make.height.equalTo(Metrics.volumeImageHeight)
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
    
    /// volume  label
    static let volumeLabelWidth: CGFloat = 30.0
    static let volumeLabelBottomOffset: CGFloat = 9.5
    
    /// volume image
    static let volumeImageTopOffset: CGFloat = 20.0
    static let volumeImageWidth: CGFloat = 18.0
    static let volumeImageHeight: CGFloat = 16.0
}
