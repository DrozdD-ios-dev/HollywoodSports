//
//  HeightPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import UIKit

// MARK: - Protocol

protocol HeightInput {
    func viewDidLoad()
    
}

final class HeightPresenter: HeightInput {
    
    // MARK: - Properties
    
    weak var view: HeightOutput?
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        
    }
}

// MARK: - Private Functions

private extension HeightPresenter {
    
}
