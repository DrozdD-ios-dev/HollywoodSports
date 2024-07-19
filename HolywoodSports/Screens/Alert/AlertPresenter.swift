//
//  AlertPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 19.07.2024.
//

import Foundation

// MARK: - Protocol

protocol AlertInput {
    func viewDidLoad()

    var user: User { get set }
}

final class AlertPresenter: AlertInput {
    
    // MARK: - Properties
    
    weak var view: AlertOutput?
    var user = CacheService.loadCache(key: StringKeys.user.rawValue) ?? User.mock
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        user.points += 50
        CacheService.saveCache(model: user, key: StringKeys.user.rawValue)
    }
}

// MARK: - Private Functions

private extension AlertPresenter {
    
}
