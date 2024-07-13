//
//  ProfileAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import Foundation

struct ProfileAssembly {
    
    static func build() -> ProfileVC {
        let presenter = ProfilePresenter()
        let vc = ProfileVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}

