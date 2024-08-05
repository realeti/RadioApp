//
//  WaveView.swift
//  RadioApp
//
//  Created by Natalia on 05.08.2024.
//

import UIKit

final class WaveView: UIView {

    private let waveImageView = UIImageView(templateImage: .wave)
    private let leftWaveCircle = UIImageView(templateImage: .waveCircle)
    private let rightWaveCircle = UIImageView(templateImage: .waveCircle)
    
    init(waveColor: UIColor, circlesColor: UIColor?) {
        super.init(frame: .zero)
        
        setWaveTint(with: waveColor)
        leftWaveCircle.tintColor = circlesColor
        rightWaveCircle.tintColor = circlesColor
        
        addSubviews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWaveTint(with color: UIColor) {
        waveImageView.tintColor = color
    }
    
    func setCirclesColor(by index: Int) {
        let color = ColorFactory.getCircleColor(for: index)
        leftWaveCircle.tintColor = color
        rightWaveCircle.tintColor = color
    }
    
    private func addSubviews() {
        addSubview(waveImageView) 
        waveImageView.addSubviews(leftWaveCircle, rightWaveCircle)
    }
    
    private func setConstraints() {
        waveImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        leftWaveCircle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2)
            make.leading.equalToSuperview().inset(-2)
            make.width.height.equalTo(waveImageView.snp.height).multipliedBy(0.37)
        }
        
        rightWaveCircle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(2)
            make.trailing.equalToSuperview().offset(2)
            make.width.height.equalTo(leftWaveCircle)
        }
    }
}
