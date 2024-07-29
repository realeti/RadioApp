//
//  Configurable.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

import UIKit

protocol Configurable: UIView {
    associatedtype Model
    
    func update(with model: Model?)
}
