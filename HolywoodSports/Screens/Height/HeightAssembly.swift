//
//  HeightAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import Foundation

struct HeightAssembly {
    
    static func build(flag: Bool) -> HeightVC {
        let presenter = HeightPresenter()
        let vc = HeightVC(presenter: presenter, flag: flag)
        presenter.view = vc
        return vc
    }
}
