//
//  AllStationsRouter.swift
//  RadioApp
//
//  Created by Дмитрий Лубов on 06.08.2024.
//

import UIKit

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

	func showStationDetails(with stationData: AllStations.Model.Station) {
		
	}
}
