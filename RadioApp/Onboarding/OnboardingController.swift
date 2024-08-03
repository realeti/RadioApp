//
//  OnboardingController.swift
//  RadioApp
//
//  Created by Мария Нестерова on 02.08.2024.
//

import UIKit
import SnapKit

class OnboardingController: UIViewController {
    var presenter: (any OnboardingPresenterProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//UI
private extension OnboardingController {
    func setupUI() {
        view.backgroundColor = .black
        
        let pic = UIImageView(image: .onboarding)
        pic.contentMode = .scaleAspectFit
        
        let colorView = UIView()
        colorView.backgroundColor = .neonBlueApp
        colorView.alpha = 0.05
        
        let bgAbove = UIImageView(image: .bgOnboarding)
        bgAbove.contentMode = .scaleAspectFill
        
        let mainLabel = UILabel()
        mainLabel.font = .systemFont(ofSize: 60, weight: .bold)
        mainLabel.textColor = .white
        mainLabel.numberOfLines = 2
        mainLabel.text = "Let's Get Started"
        
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 16, weight: .regular)
        textLabel.textColor = .white
        textLabel.numberOfLines = 0
        textLabel.text = "Enjoy the best radio stations \nfrom your home, don't miss \nout on anything"
        
        let startButton = UIButton()
        startButton.setTitle("Get Started", for: .normal)
        startButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        startButton.backgroundColor = .pinkApp
        startButton.tintColor = .white
        startButton.layer.cornerRadius = 10
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        
        view.addSubview(pic)
        view.addSubview(colorView)
        view.addSubview(bgAbove)
        view.addSubview(mainLabel)
        view.addSubview(textLabel)
        view.addSubview(startButton)
        
        pic.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(40)
            make.top.equalToSuperview().inset(140)
            make.bottom.equalToSuperview().inset(-24)
            make.trailing.equalToSuperview()
        }
        
        colorView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        bgAbove.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(190)
            make.leading.trailing.equalToSuperview().inset(52)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(mainLabel)
            make.top.equalTo(mainLabel.snp.bottom).inset(-30)
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(mainLabel)
            make.height.equalTo(58)
            make.bottom.equalToSuperview().inset(53)
        }
    }
    
    
    @objc func startTapped() {
        print("start tapped")
        presenter?.goToAutorization()
    }
}

@available(iOS 17.0, *)
#Preview {
    Builder.createOnboarding()
}
