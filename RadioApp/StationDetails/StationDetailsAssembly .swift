//
//  StationDetailsAssembly .swift
//  RadioApp
//
//  Created by Alexander on 5.08.24.
//

import UIKit

final class StationDetailsAssembly {
    func build(with station: RadioStation) -> UIViewController {
        let view = StationDetailsController()
        let presenter = StationDetailsPresenter(view: view, station: station)
        view.presenter = presenter
        view.playerVolumeIsHidden = true
        
        return view
    }
}
