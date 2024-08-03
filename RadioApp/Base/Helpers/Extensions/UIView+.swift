//
//  UIView+.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
}
