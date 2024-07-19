//
//  AlertAssebbly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 19.07.2024.
//

import Foundation

struct AlertAssembly {
    
    static func build() -> AlertVC {
        let presenter = AlertPresenter()
        let vc = AlertVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
