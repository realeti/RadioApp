//
//  VolumeSlider.swift
//  RadioApp
//
//  Created by realeti on 09.08.2024.
//

import UIKit

final class VolumeSlider: UISlider {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSlider()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Set Custom Height
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customHeight: CGFloat = Metrics.trackHeight
        let customRect = CGRect(
            x: bounds.origin.x,
            y: (bounds.size.height - customHeight) / 2,
            width: bounds.size.width,
            height: customHeight
        )
        return customRect
    }
    
    // MARK: - Setup Slider Properties
    private func setupSlider() {
        minimumTrackTintColor = .neonBlueApp
        maximumTrackTintColor = .martimeBlue
        thumbTintColor = .neonBlueApp
        
        let thumbImage = createThumbImage(
            size: CGSize(
                width: Metrics.thumbSize,
                height: Metrics.thumbSize),
            color: .neonBlueApp
        )
        
        setThumbImage(thumbImage, for: .normal)
        setThumbImage(thumbImage, for: .highlighted)
    }
    
    // MARK: - Create ThumbImage
    private func createThumbImage(size: CGSize, color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        
        let circlePath = UIBezierPath(ovalIn: CGRect(origin: .zero, size: size))
        circlePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

fileprivate struct Metrics {
    static let trackHeight: CGFloat = 3.0
    static let thumbSize: CGFloat = 10.0
    
    private init() {}
}
