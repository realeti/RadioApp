//
//  ColorFactory.swift
//  RadioApp
//
//  Created by realeti on 03.08.2024.
//

import UIKit

struct ColorFactory {
    static let circleColors: [UIColor] = [
        .darkPinkCircle,
        .blueCircle,
        .magentaCircle,
        .greenCircle,
        .yellowCircle,
        .orangeCircle
    ]
    
    static func getCircleColor(for index: Int) -> UIColor {
        return circleColors[index % circleColors.count]
    }
    
    static func getRandomCircleColor() -> UIColor? {
        return circleColors.randomElement()
    }
}
