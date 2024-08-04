//
//  UIStackView + Extensions.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach(addArrangedSubview)
    }
}

extension UIStackView {
    convenience init(
        axis: NSLayoutConstraint.Axis,
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution,
        alignment: UIStackView.Alignment = .fill
    ) {
        self.init()
        
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
