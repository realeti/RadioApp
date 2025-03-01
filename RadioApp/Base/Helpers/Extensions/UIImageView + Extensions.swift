//
//  UIImageView + Extensions.swift
//  RadioApp
//
//  Created by realeti on 03.08.2024.
//

import UIKit

extension UIImageView {
    convenience init(
        image: UIImage? = nil,
        contentMode: UIView.ContentMode,
        renderingMode: UIImage.RenderingMode = .alwaysOriginal,
        isHidden: Bool = false
    ) {
        self.init()
        
        self.image = image?.withRenderingMode(renderingMode)
        self.contentMode = contentMode
        self.isHidden = isHidden
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(templateImage: UIImage, renderingMode: UIImage.RenderingMode = .alwaysTemplate) {
        self.init()
        self.image = templateImage.withRenderingMode(renderingMode)
    }
}
