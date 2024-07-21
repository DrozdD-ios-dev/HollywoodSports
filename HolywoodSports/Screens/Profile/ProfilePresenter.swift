//
//  ProfilePresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

// MARK: - Protocol

protocol ProfileInput {
    func viewWillAppear()
    func nextAction(index: Int)
    
    var rows: [String] { get }
    var user: User { get set }
    var userViews: [UserDataView] { get set }
}

final class ProfilePresenter: ProfileInput {
    
    // MARK: - Properties
    
    weak var view: ProfileOutput?
    var rows = ["Change your gender", "Change your weigth", "Change your height"]
    var user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
    var userViews = [UserDataView]()
 
    // MARK: - Public Functions
    
    func viewWillAppear() {
        updateUserData()
    }
    
    func nextAction(index: Int) {
        switch index {
        case 0:
            view?.openGenderVC()
        case 1:
            view?.openWeightVC()
        case 2:
            view?.openHeightVC()
        default:
            break
        }
    }
}

// MARK: - Private Functions

private extension ProfilePresenter {
    
    func updateUserData() {
        user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
        userViews[0].configure(with: user.gender.rawValue.firstUppercased)
        userViews[1].configure(with: "\(user.weight) \(user.weightType)")
        userViews[2].configure(with: "\(user.height) \(user.heightType)")
        view?.updateImage()
    }
  
}
