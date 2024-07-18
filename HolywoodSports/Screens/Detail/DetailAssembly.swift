//
//  DetailAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 17.07.2024.
//

import Foundation

struct DetailAssembly {
    
    static func build(training: Training, index: Int) -> DetailVC {
        let presenter = DetailPresenter(training: training, index: index)
        let vc = DetailVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
