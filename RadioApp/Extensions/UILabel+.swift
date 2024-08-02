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

