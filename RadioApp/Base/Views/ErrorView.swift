//
//  ErrorView.swift
//  RadioApp
//
//  Created by Мария Нестерова on 07.08.2024.
//

import UIKit
import Lottie

final class ErrorView: UIView {
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var message: String? {
        didSet {
            messageLabel.text = message
            messageLabel.isHidden = message == nil
        }
    }
    
    var actionTitle: String? {
        didSet {
            actionButton.setTitle(actionTitle, for: .normal)
        }
    }
    
    var action: ((UIView) -> Void)? {
        didSet {
            actionButton.isHidden = action == nil
        }
    }
    
    let animation = LottieAnimationView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let actionButton = UIButton()
    private let errorStack = UIStackView()
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .darkBlueApp
        
        animation.animation = .filepath(Bundle.main.path(forResource: "error", ofType: "json") ?? "")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .playOnce
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        animation.snp.makeConstraints {
            $0.size.equalTo(60)
        }
        
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.alignment = .center
        textStack.spacing = 8
        
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(messageLabel)
        
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = .neonBlueApp
        configuration.baseForegroundColor = .white
        configuration.titleAlignment = .center
        configuration.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        actionButton.configuration = configuration
        actionButton.isHidden = true
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        addSubviews(errorStack)
        errorStack.axis = .vertical
        errorStack.alignment = .center
        errorStack.spacing = 24
        errorStack.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        errorStack.addArrangedSubviews(animation, textStack, actionButton)
        
    }
    
    @objc
    private func didTapActionButton() {
        action?(self)
    }
}
