//
//  HomeAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import Foundation

struct HomeAssembly {
    
    static func build() -> HomeVC {
        let presenter = HomePresenter()
        let vc = HomeVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
