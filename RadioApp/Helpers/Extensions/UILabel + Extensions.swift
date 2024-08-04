//
//  UILabel + Extensions.swift
//  RadioApp
//
//  Created by realeti on 03.08.2024.
//

import UIKit

extension UILabel {
    convenience init(text: String? = nil, color: UIColor = .white, font: UIFont, alignment: NSTextAlignment = .left) {
        self.init()
        
        self.text = text
        self.textColor = color
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
