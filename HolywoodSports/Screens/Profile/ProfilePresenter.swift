//
//  ProfilePresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

// MARK: - Protocol

protocol ProfileInput {
    func viewDidLoad()
    func updateUserData()
    
    var rows: [String] { get }
    var user: User { get set }
    var userViews: [UserDataView] { get set }
}

final class ProfilePresenter: ProfileInput {
    
    // MARK: - Properties
    
    weak var view: ProfileOutput?
    var rows = ["Change your gender", "Change your weigth", "Change your height"]
    var user = UserService.loadUser(key: "user") ?? User.mock
    var userViews = [UserDataView]()
    
    
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        updateUserData()
    }
    
    func updateUserData() {
        user = UserService.loadUser(key: "user") ?? User.mock
        userViews[0].configure(with: user.gender.rawValue.firstUppercased)
        userViews[1].configure(with: "\(user.weight) \(user.weightValue)")
        userViews[2].configure(with: "\(user.height) \(user.heightValue)")
        view?.updateImage()
    }
}

// MARK: - Private Functions

private extension ProfilePresenter {
    
  
}
