//
//  StationFormatter.swift
//  RadioApp
//
//  Created by realeti on 17.08.2024.
//

import Foundation
import RadioBrowser

struct StationFormatter {
    static func formatNames(_ station: Station) -> (title: String, subtitle: String) {
        var title = station.name
            .trimmingCharacters(in: .whitespacesAndNewlines)
        var subtitle = station.tags.first?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? K.unknownTag
        
        if title.isEmpty {
            title = K.unknownName
        }
        
        if subtitle.isEmpty {
            subtitle = K.unknownTag
        }
        
        return (title: title, subtitle: subtitle)
    }
}
