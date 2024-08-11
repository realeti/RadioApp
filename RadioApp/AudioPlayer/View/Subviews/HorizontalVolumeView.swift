//
//  HorizontalVolumeView.swift
//  RadioApp
//
//  Created by realeti on 10.08.2024.
//

import UIKit
import SnapKit

final class HorizontalVolumeView: UIView {
    // MARK: - UI
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
    weak var delegate: VolumePlayerProtocol?
    
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
        addSubviews(
            volumeContainer,
            volumeLabel,
            volumeImageView
        )
        
        volumeContainer.addSubview(volumeSlider)
    }
}

// MARK: - External Methods
extension HorizontalVolumeView {
    func update(_ volume: Float) {
        volumeSlider.value = volume
        updateVolumeLabel(volume)
    }
}

// MARK: - Setup Actions
private extension HorizontalVolumeView {
    func setupActions() {
        volumeSlider.addTarget(self, action: #selector(volumeSliderChanged), for: .valueChanged)
    }
    
    // Actions
    @objc private func volumeSliderChanged(_ sender: UISlider) {
        updateVolumeLabel(sender.value)
        delegate?.updatePlayerVolume(sender.value)
    }
}

// MARK: - Update Volume Label
private extension HorizontalVolumeView {
    func updateVolumeLabel(_ volume: Float) {
        let volumeValue = String(format: "%.0f", volume * 100.0)
        volumeLabel.text = volumeValue + "%"
    }
}

// MARK: - Setup Constraints
private extension HorizontalVolumeView {
    func setupConstraints() {
        setupVolumeContainerConstraints()
        setupVolumeSliderConstraints()
        setupVolumeLabelConstraints()
        setupVolumeImageViewConstraints()
    }
    
    func setupVolumeContainerConstraints() {
        volumeContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(K.volumeContainerHeight)
            make.height.equalTo(K.volumeContainerWidth)
        }
    }
       
    func setupVolumeSliderConstraints() {
        volumeSlider.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(K.volumeContainerHeight)
            make.height.equalTo(K.volumeContainerWidth)
        }
    }
    
    func setupVolumeLabelConstraints() {
        volumeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(volumeContainer.snp.centerY)
            make.leading.equalTo(volumeContainer.snp.trailing).offset(Metrics.volumeLabelLeadingOffset)
            make.width.equalTo(Metrics.volumeLabelWidth)
        }
    }
    
    func setupVolumeImageViewConstraints() {
        volumeImageView.snp.makeConstraints { make in
            make.centerY.equalTo(volumeContainer.snp.centerY)
            make.trailing.equalTo(volumeContainer.snp.leading).offset(-Metrics.volumeImageTrailingOffset)
            make.width.equalTo(Metrics.volumeImageWidth)
            make.height.equalTo(Metrics.volumeImageHeight)
        }
    }
}

fileprivate struct Metrics {
    /// volume  label
    static let volumeLabelWidth: CGFloat = 30.0
    static let volumeLabelLeadingOffset: CGFloat = 9.5
    
    /// volume image
    static let volumeImageTrailingOffset: CGFloat = 20.0
    static let volumeImageWidth: CGFloat = 18.0
    static let volumeImageHeight: CGFloat = 16.0
    
    private init() {}
}
