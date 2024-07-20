//
//  GenderAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import Foundation

struct GenderAssembly {
    
    static func build(flag: Bool) -> GenderVC {
        let presenter = GenderPresenter(flag: flag)
        let vc = GenderVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
