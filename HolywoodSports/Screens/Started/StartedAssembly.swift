//
//  StartedAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import Foundation

struct StartedAssembly {
    
    static func build() -> StartedVC {
        let presenter = StartedPresenter()
        let vc = StartedVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
