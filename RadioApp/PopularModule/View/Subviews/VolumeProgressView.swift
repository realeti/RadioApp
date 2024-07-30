//
//  VolumeProgressView.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import UIKit

final class VolumeProgressView: UIView {
    // MARK: - UI
    private lazy var volumeProgressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .martimeBlue
        view.progressTintColor = .neonBlueApp
        view.progress = 0.5
        return view
    }()
    
    private let progressCircleLayer = CAShapeLayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        setupProgressCircleLayer()
        
        setVolumeProgress(0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - VolumeProgress Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        volumeProgressView.transform = CGAffineTransform(rotationAngle: .pi / -2)
    }
    
    // MARK: - Set Views
    func setupUI() {
        addSubview(volumeProgressView)
    }
    
    private func setupProgressCircleLayer() {
        let circleRadius: CGFloat = 10.0
        let circlePath = UIBezierPath(
            arcCenter: .zero,
            radius: circleRadius,
            startAngle: 0,
            endAngle: CGFloat.pi * 2,
            clockwise: true
        )

        progressCircleLayer.path = circlePath.cgPath
        progressCircleLayer.fillColor = UIColor.neonBlueApp.cgColor
        progressCircleLayer.bounds = CGRect(origin: .zero, size: CGSize(width: circleRadius * 2, height: circleRadius * 2))
        progressCircleLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        volumeProgressView.layer.addSublayer(progressCircleLayer)
    }

    private func setVolumeProgress(_ progress: Float) {
        volumeProgressView.progress = progress
        updateProgressCirclePosition()
    }

    private func updateProgressCirclePosition() {
        let progress = volumeProgressView.progress
        let trackHeight = volumeProgressView.bounds.height
        let trackWidth = volumeProgressView.bounds.width
        let progressCircleRadius = progressCircleLayer.bounds.width / 2
        let yOffset = trackHeight * CGFloat(progress)
        let xOffset = CGFloat(progress) / trackWidth
        print(xOffset, yOffset)
        let xPos = volumeProgressView.frame.maxX - yOffset
        let yPos = volumeProgressView.frame.minY + yOffset + progressCircleRadius

        progressCircleLayer.position = CGPoint(x: xPos, y: yPos)
    }
}

// MARK: - Setup Constraints
private extension VolumeProgressView {
    func setupConstraints() {
        setupVolumeProgressConstraints()
    }
    
    func setupVolumeProgressConstraints() {
        volumeProgressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(196.0)
            make.height.equalTo(5.0)
        }
    }
}
