//
//  PopularBuilder.swift
//  RadioApp
//
//  Created by realeti on 30.07.2024.
//

import UIKit

extension Builder {
    static func createDetails() -> UIViewController {
        let view = UIViewController() // DetailViewController
        //let presenter = DetailPresenter(view: view)
        //view.presenter = presenter
        return view
    }
}
