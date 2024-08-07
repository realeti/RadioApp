//
//  LoadingView.swift
//  RadioApp
//
//  Created by Мария Нестерова on 05.08.2024.
//

import UIKit
import Lottie
import SnapKit

final class LoadingView: UIView {
    let animation = LottieAnimationView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .darkBlueApp
        animation.animation = .filepath(Bundle.main.path(forResource: "loading", ofType: "json") ?? "")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .autoReverse
        animation.play()
        
        addSubview(animation)
        
        animation.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        animation.stop()
    }
    
}
