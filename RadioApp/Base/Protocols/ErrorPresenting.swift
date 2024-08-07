//
//  ErrorPresenting.swift
//  RadioApp
//
//  Created by Мария Нестерова on 07.08.2024.
//

import UIKit

protocol ErrorPresenting {
    func showError(
        title: String,
        message: String?,
        actionTitle: String?,
        action: ((UIView) -> Void)?
    )
    
    func hideError()
}
