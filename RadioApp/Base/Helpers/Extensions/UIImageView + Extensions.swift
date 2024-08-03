//
//  UIImageView + Extensions.swift
//  RadioApp
//
//  Created by realeti on 03.08.2024.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage? = nil, contentMode: UIView.ContentMode, isHidden: Bool = false) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
        self.isHidden = isHidden
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
