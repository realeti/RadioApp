//
//  UIView + Extensions.swift
//  RadioApp
//
//  Created by realeti on 29.07.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        for view in subviews {
            addSubview(view)
        }
    }
    
    func addSubviews(_ subviews: [UIView]) {
        for view in subviews {
            addSubview(view)
        }
    }
}
