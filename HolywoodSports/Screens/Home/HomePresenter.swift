//
//  HomePresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

// MARK: - Protocol

protocol HomeInput {
    func viewDidLoad()
    
    var user: User { get }
    var trainingsOneDay: [Training] { get set }
    var weekDays: [Day] { get set }
}

final class HomePresenter: HomeInput {
    
    // MARK: - Properties
    
    weak var view: HomeOutput?
    var user = CacheService.loadCache(key: StringKeys.user.rawValue) ?? User.mock
    var trainingsOneDay = CacheService.loadCache(key: StringKeys.oneDayTrainings.rawValue) ?? Training.mock
    var weekDays = Day.mock
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        let userNew = CacheService.loadCache(key: "user") ?? User.mock
        user = userNew
    }
}

// MARK: - Private Functions

private extension HomePresenter {

}
