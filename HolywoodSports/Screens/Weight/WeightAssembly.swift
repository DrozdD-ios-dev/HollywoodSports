//
//  WeightAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import Foundation

struct WeightAssembly {
    
    static func build(flag: Bool) -> WeightVC {
        let presenter = WeightPresenter(flag: flag)
        let vc = WeightVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
