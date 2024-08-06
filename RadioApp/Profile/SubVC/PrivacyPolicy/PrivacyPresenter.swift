//
//  PrivacyPresenter.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation

protocol PrivacyViewProtocol: AnyObject {
}

protocol PrivacyPresenterProtocol: AnyObject {
}

final class PrivacyPresenter: PrivacyPresenterProtocol {
    weak var view: PrivacyViewProtocol?
    init(view: PrivacyViewProtocol) {
        self.view = view
    }
}
