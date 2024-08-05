//
//  LanguagePresenter.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation

struct Language {
    let language: String
    var isSelected: Bool
    let id: AppLanguage
}

// MARK: - LanguagePresenterProtocol
protocol LanguagePresenterProtocol {
    init(view: LanguageVCProtocol)
    var languages:  [Language] { get }
    var isShouldReloadRootController: Bool { get }
    func whatLanguageSelected()
    func selectALanguage(index: Int)
}

// MARK: - LanguagePresenter
final class LanguagePresenter: LanguagePresenterProtocol {
    
    private unowned var view: LanguageVCProtocol
    
    var languages:  [Language] = [
        Language(language: "English", isSelected: false, id: .english),
        Language(language: "Русский", isSelected: false, id: .russian)
    ]
    /// Флаг для рут
    private(set) var isShouldReloadRootController = false
    
    init(view: LanguageVCProtocol) {
        self.view = view
    }
    
    func whatLanguageSelected() {
        for i in 0...languages.count - 1 {
            if UDService.getLanguage() == languages[i].id.rawValue {
                languages[i].isSelected = true
            }
        }
    }
    
    func selectALanguage(index: Int) {
        /// проверка изменился ли язык
        if UDService.getLanguage() != languages[index].id.rawValue {
            isShouldReloadRootController = true
        }

        languages.indices.forEach { languages[$0].isSelected = false }
        languages[index].isSelected = true
        UDService.switchLanguage(to: languages[index].id)
    }

    
}

