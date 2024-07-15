//
//  SecondAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import Foundation

struct SecondAssembly {
    
    static func build() -> SecondVC {
        let presenter = SecondPresenter()
        let vc = SecondVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
