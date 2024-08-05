//
//  ExamplePresenter.swift
//  RadioApp
//
//  Created by Мария Нестерова on 30.07.2024.
//

import Foundation

final class ExamplePresenter: ExamplePresenterProtocol {
    
    var view: (any ExampleControllerProtocol)?
    var router: (any ExampleRouterProtocol)?
    //private let networkService: NetworkService

    func activate() {
        Task {
//            let result = await networkService.sendRequest()...
//            await updateUI(with: result)
            let mockResult = [Example(login: "1", email: "1"), Example(login: "2", email: "2")]
            await updateUI(with: mockResult)
        }
    }
    
    func didTapSomeButton() {
        
    }
    
    @MainActor
    private func updateUI(with examples: [Example]) {
        view?.update(with: .init(examples: examples))
    }
    
}
