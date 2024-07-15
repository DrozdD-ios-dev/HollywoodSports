//
//  StartedPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

// MARK: - Protocol

protocol StartedInput {
    func viewDidLoad()
    
}

final class StartedPresenter: StartedInput {
    
    // MARK: - Properties
    
    weak var view: StartedOutput?
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        
    }
}

// MARK: - Private Functions

private extension StartedPresenter {
    
}
