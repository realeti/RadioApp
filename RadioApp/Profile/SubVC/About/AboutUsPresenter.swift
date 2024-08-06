//
//  AboutUsPresenter.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation

protocol AboutViewControllerProtocol: AnyObject {
    
}

protocol AboutUsPresenterProtocol: AnyObject {
    
}

final class AboutUsPresenter: AboutUsPresenterProtocol {
    weak var view: AboutViewControllerProtocol?
    init(view: AboutViewControllerProtocol? = nil) {
        self.view = view
    }
}
