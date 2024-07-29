//
//  ExampleCellView.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import UIKit

final class ExampleCellView: UIView, CellConfigurable {
    let loginLabel = UILabel()
    let emailLabel = UILabel()

    func update(with model: Example?) {
        loginLabel.text = model?.login
        emailLabel.text = model?.email
    }
}
