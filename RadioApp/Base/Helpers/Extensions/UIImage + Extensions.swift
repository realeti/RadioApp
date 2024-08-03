//
//  UIImage + Extensions.swift
//  RadioApp
//
//  Created by realeti on 03.08.2024.
//

import UIKit

extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        return withRenderingMode(.alwaysOriginal).withTintColor(color)
    }
}
