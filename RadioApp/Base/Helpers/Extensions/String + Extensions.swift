//
//  String + Extensions.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import Foundation

extension String {
    var localized: String {
        let lang = UDService.getLanguage()
        
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
