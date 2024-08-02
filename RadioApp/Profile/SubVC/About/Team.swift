//
//  Team.swift
//  RadioApp
//
//  Created by Иван Семенов on 31.07.2024.
//

import UIKit

struct TeamPayer {
    let image: UIImage
    let role: String
    let gitHub: String
}

struct Team {
    static let team: [TeamPayer] = [
        TeamPayer(image: .ridebyhorse,
                  role: "TeamLeader".localized,
                  gitHub: "https://github.com/ridebyhorse"),
        TeamPayer(image: .realeti,
                  role: "IOS Developer".localized,
                  gitHub: "https://github.com/realeti"),
        TeamPayer(image: .dr4Gons1Ayer01,
                  role: "IOS Developer".localized,
                  gitHub: "https://github.com/dr4gons1ayer01"),
        TeamPayer(image: .shapovalovIlya,
                  role: "IOS Developer".localized,
                  gitHub: "https://github.com/ShapovalovIlya"),
        TeamPayer(image: .natalyaLuzyanina,
                  role: "IOS Developer".localized,
                  gitHub: "https://github.com/NatalyaLuzyanina"),
        TeamPayer(image: .dmitriyLubov,
                  role: "IOS Developer".localized,
                  gitHub: "https://github.com/DmitriyLubov"),
        TeamPayer(image: .AML_1708,
                  role: "IOS Developer".localized,
                  gitHub: "https://github.com/AML1708")
    ]
}
