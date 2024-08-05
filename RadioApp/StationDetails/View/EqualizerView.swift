//
//  EqualizerView.swift
//  RadioApp
//
//  Created by Alexander on 5.08.24.
//

import UIKit

final class EqualizerView: UIView {
    
    private var bars: [UIView] = []
    private var isAnimating = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBars()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBars() {
        for _ in 0..<5 {
            let bar = UIView()
            bar.backgroundColor = .white
            addSubview(bar)
            bars.append(bar)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        for (index, bar) in bars.enumerated() {
            bar.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.width.equalTo(20)
                make.height.equalTo(50)
                make.leading.equalToSuperview().offset(CGFloat(index) * 40)
            }
        }
    }
    
    func startAnimating() {
        isAnimating = true
        animateBars()
    }
    
    func stopAnimating() {
        isAnimating = false
    }
    
    private func animateBars() {
          guard isAnimating else { return }
          
          UIView.animate(withDuration: 0.3, animations: {
              for bar in self.bars {
                  let height = CGFloat(arc4random_uniform(50) + 10)
                  bar.snp.updateConstraints { make in
                      make.height.equalTo(height)
                  }
              }
              self.layoutIfNeeded()
          }) { _ in
              self.animateBars()
          }
      }
}
