//
//  WeightAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import Foundation

struct WeightAssembly {
    
    static func build(flag: Bool) -> WeightVC {
        let presenter = WeightPresenter()
        let vc = WeightVC(presenter: presenter, flag: flag)
        presenter.view = vc
        return vc
    }
}
