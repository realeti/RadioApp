//
//  EqualizerView.swift
//  RadioApp
//
//  Created by Alexander on 5.08.24.
//

import UIKit
import Lottie

final class EqualizerView: UIView {
    private var isAnimating = false
    private let animation = LottieAnimationView()
    
    init() {
        super.init(frame: .zero)
        animation.animation = .filepath(Bundle.main.path(forResource: "wave", ofType: "json") ?? "")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(animation)
        
        animation.snp.makeConstraints {
            $0.size.equalTo(300)
            $0.centerX.equalToSuperview()
        }
    }
    
    func startAnimating() {
        isAnimating = true
        animation.play()
    }
    
    func stopAnimating() {
        isAnimating = false
        animation.pause()
    }
}
