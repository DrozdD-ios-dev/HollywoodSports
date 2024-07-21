//
//  GenderPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import UIKit

// MARK: - Protocol

protocol GenderInput {
    func selectGenderView(index: Int)
}

final class GenderPresenter: GenderInput {
    
    // MARK: - Properties
    
    weak var view: GenderOutput?
    private var user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
    private var flag: Bool
    
    // MARK: - Init
    
    init(flag: Bool) {
        self.flag = flag
    }
}

// MARK: - Public Function

extension GenderPresenter {
    
    func selectGenderView(index: Int) {
        view?.selectGenderView(index: index)
        user.gender = Gender.allCases[index]
        CacheService.saveCache(model: user, key: DefaultKey.user)
        NotificationCenter.default.post(name: Notification.Name("UpdateUser"), object: nil)
        
        if flag {
            view?.nextVC()
        } else {
            view?.dismiss()
        }
    }
}
