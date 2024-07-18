//
//  SportPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

// MARK: - Protocol

protocol SportInput {
    func viewDidLoad()
    
    var trainingAll: [Training] { get }
    var trainingsOneDay: [Training] { get set }
    var user: User { get set }
}

final class SportPresenter: SportInput {
    
    // MARK: - Properties
    
    weak var view: SportOutput?
    var user: User = CacheService.loadCache(key: "user") ?? User.mock
    let trainingAll = CacheService.loadCache(key: StringKeys.allTrainings.rawValue) ?? Training.mock
//    var trainingsOneDayTemp: [Training] {
//        return trainingAll.shuffled().dropLast(2)
//    }
    
    var trainingsOneDay = CacheService.loadCache(key: StringKeys.oneDayTrainings.rawValue) ?? Training.mock
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        let userNew = CacheService.loadCache(key: "user") ?? User.mock
        user = userNew
    }
}

// MARK: - Private Functions

private extension SportPresenter {

}
