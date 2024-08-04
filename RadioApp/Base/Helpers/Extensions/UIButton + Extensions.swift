//
//  UIButton + Extensions.swift
//  RadioApp
//
//  Created by realeti on 04.08.2024.
//

import UIKit

extension UIButton {
    convenience init(backgroundImage: UIImage) {
        self.init(type: .custom)

        self.setBackgroundImage(backgroundImage, for: .normal)
        self.setBackgroundImage(backgroundImage, for: .highlighted)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
