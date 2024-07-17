//
//  DetailAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 17.07.2024.
//

import Foundation

struct DetailAssembly {
    
    static func build() -> DetailVC {
        let presenter = DetailPresenter()
        let vc = DetailVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
