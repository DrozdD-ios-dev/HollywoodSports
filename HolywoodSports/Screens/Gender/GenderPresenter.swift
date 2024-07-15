//
//  GenderPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import UIKit

// MARK: - Protocol

protocol GenderInput {
    func viewDidLoad()
    
    var user: User { get set }
}

final class GenderPresenter: GenderInput {
    
    // MARK: - Properties
    
    weak var view: GenderOutput?
    var user = UserService.loadUser(key: "user") ?? User.mock
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        
    }
}

// MARK: - Private Functions

private extension GenderPresenter {
    
}
