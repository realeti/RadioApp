//
//  AllStationsAssembly.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 05.08.2024.
//

import UIKit
import RadioBrowser

final class AllStationsAssembly: ModuleAssembly {

	func build(router: AllStationsRouterProtocol) -> UIViewController {
		let controller = AllStationsController()
		let presenter = AllStationsPresenter(
			router: router,
			view: controller,
			radioBrowser: RadioBrowser.default,
			storageManager: StorageManager.shared
		)
		controller.presenter = presenter

		return controller
	}
}
