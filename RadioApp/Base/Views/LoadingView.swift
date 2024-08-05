//
//  LoadingView.swift
//  RadioApp
//
//  Created by Мария Нестерова on 05.08.2024.
//

import UIKit
import Lottie
import SnapKit

final class LoadingView: UIViewController {
    let animation = LottieAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlueApp
        animation.animation = .filepath(Bundle.main.path(forResource: "loading", ofType: "json") ?? "")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .autoReverse
        animation.play()
        
        view.addSubview(animation)
        
        animation.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.center.equalToSuperview()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animation.stop()
    }
}
