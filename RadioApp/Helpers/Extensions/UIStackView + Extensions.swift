//
//  UIStackView + Extensions.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        for view in subviews {
            addArrangedSubview(view)
        }
    }
    
    func addArrangedSubviews(_ subviews: [UIView]) {
        for view in subviews {
            addArrangedSubview(view)
        }
    }
}
