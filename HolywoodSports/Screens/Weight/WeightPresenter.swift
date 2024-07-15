//
//  WeightPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import UIKit

// MARK: - Protocol

protocol WeightInput {
    func viewDidLoad()
    
    var user: User { get set }
}

final class WeightPresenter: WeightInput {
    
    // MARK: - Properties
    
    weak var view: WeightOutput?
    var user = UserService.loadUser(key: "user") ?? User.mock
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        
    }
}

// MARK: - Private Functions

private extension WeightPresenter {
    
}
