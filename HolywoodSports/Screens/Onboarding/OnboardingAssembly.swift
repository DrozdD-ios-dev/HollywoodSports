//
//  OnboardingAssembly.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import Foundation

struct OnboardingAssembly {
    
    static func build() -> OnboardingVC {
        let presenter = OnboardingPresenter()
        let vc = OnboardingVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
