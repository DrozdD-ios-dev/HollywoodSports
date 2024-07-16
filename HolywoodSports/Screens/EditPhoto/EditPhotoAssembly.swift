//
//  EditPhotoAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import Foundation

struct EditPhotoAssembly {
    
    static func build(flag: Bool) -> EditPhotoVC {
        let presenter = EditPhotoPresenter()
        let vc = EditPhotoVC(presenter: presenter, flag: flag)
        presenter.view = vc
        return vc
    }
}
