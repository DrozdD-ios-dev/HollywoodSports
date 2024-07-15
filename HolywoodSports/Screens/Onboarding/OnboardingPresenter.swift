//
//  OnboardingPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

// MARK: - Protocol

protocol OnboardingInput {
    func viewDidLoad()
    
}

final class OnboardingPresenter: OnboardingInput {
    
    // MARK: - Properties
    
    weak var view: OnboardingOutput?
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        
    }
}

// MARK: - Private Functions

private extension OnboardingPresenter {
    
}
