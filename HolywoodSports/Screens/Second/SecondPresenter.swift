//
//  SecondPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

// MARK: - Protocol

protocol SecondInput {
    func viewDidLoad()
    
}

final class SecondPresenter: SecondInput {
    
    // MARK: - Properties
    
    weak var view: SecondOutput?
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        
    }
}

// MARK: - Private Functions

private extension SecondPresenter {
    
}
