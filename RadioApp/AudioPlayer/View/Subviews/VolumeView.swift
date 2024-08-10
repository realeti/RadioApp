//
//  VolumeView.swift
//  RadioApp
//
//  Created by realeti on 10.08.2024.
//

import UIKit
import SnapKit

final class VolumeView: UIView {
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
    
    // MARK: - Public Properties
    var axis: VolumeAxis = .vertical {
        didSet {
            //print("volume axis change")
        }
    }
    
    // MARK: - Delegate
    weak var delegate: AudioPlayerViewProtocol?
    
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
    
    // MARK: - Rotate Volume Slider
    override func layoutSubviews() {
        super.layoutSubviews()
        volumeSlider.transform = CGAffineTransform(rotationAngle: .pi / -2)
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
extension VolumeView {
    func update(_ volume: Float) {
        volumeSlider.value = volume
        updateVolumeLabel(volume)
    }
}

// MARK: - Setup Actions
private extension VolumeView {
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
private extension VolumeView {
    func updateVolumeLabel(_ volume: Float) {
        let volumeValue = String(format: "%.0f", volume * 100.0)
        volumeLabel.text = volumeValue + "%"
    }
}

// MARK: - Setup Constraints
private extension VolumeView {
    func setupConstraints() {
        setupVolumeContainerConstraints()
        setupVolumeSliderConstraints()
        setupVolumeLabelConstraints()
        setupVolumeImageViewConstraints()
    }
    
    func setupVolumeContainerConstraints() {
        volumeContainer.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(K.volumeContainerWidth)
            make.height.equalTo(K.volumeContainerHeight)
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
    /// volume  label
    static let volumeLabelWidth: CGFloat = 30.0
    static let volumeLabelBottomOffset: CGFloat = 9.5
    
    /// volume image
    static let volumeImageTopOffset: CGFloat = 20.0
    static let volumeImageWidth: CGFloat = 18.0
    static let volumeImageHeight: CGFloat = 16.0
    
    private init() {}
}
