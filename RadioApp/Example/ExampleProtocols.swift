//
//  ExampleProtocols.swift
//  RadioApp
//
//  Created by Мария Нестерова on 29.07.2024.
//

protocol ExampleControllerProtocol: AnyObject {
    func update(with model: ExampleController.Model)
}

protocol ExamplePresenterProtocol: AnyObject {
    func activate()
    func didTapSomeButton()
}

protocol ExampleRouterProtocol: AnyObject {
    func showExampleVC2()
    func showExampleVC3()
}
