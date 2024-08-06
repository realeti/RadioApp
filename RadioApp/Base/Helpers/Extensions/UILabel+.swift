//
//  UILabel+.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import UIKit

extension UILabel {
    static func makeLabel(
        font: UIFont?,
        color: UIColor?,
        numberOfLines: Int = 1,
        alignment: NSTextAlignment = .center
    ) -> UILabel {
        let label = UILabel()
        label.font = font
        label.textColor = color
        label.numberOfLines = numberOfLines
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textAlignment = alignment
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension UILabel {
    convenience init(
        text: String? = nil,
        color: UIColor = .white,
        font: UIFont,
        alignment: NSTextAlignment = .left
    ) {
        self.init()
        
        self.text = text
        self.textColor = color
        self.font = font
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.8
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
