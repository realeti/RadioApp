//
//  AudioAssembly.swift
//  RadioApp
//
//  Created by realeti on 06.08.2024.
//

import UIKit

final class AudioAssembly: ModuleAssembly {
    func build() -> UIViewController {
        let viewController = AudioPlayerViewController()
        let presenter = AudioPlayerPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
