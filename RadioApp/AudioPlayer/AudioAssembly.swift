//
//  AudioAssembly.swift
//  RadioApp
//
//  Created by realeti on 06.08.2024.
//

import UIKit

final class AudioAssembly {
    func build() -> UIViewController {
        let presenter = AudioPlayerPresenter()
        let controller = AudioPlayerViewController(presenter: presenter)
        presenter.view = controller
        return controller
    }
}
