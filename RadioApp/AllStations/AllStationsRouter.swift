//
//  AllStationsRouter.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 06.08.2024.
//

import UIKit
import RadioBrowser

final class AllStationsRouter: AllStationsRouterProtocol {

	private let builder: AllStationsAssembly
	private let navigation: UINavigationController

	init(builder: AllStationsAssembly, navigation: UINavigationController) {
		self.builder = builder
		self.navigation = navigation
	}

	func showAllStations() {
		let controller = builder.build(router: self)
		navigation.viewControllers = [controller]
	}

	func showStationDetails(with stationData: Station) {
		let controller = StationDetailsAssembly().build()
		navigation.pushViewController(controller, animated: true)
	}
}
