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
    func viewWillAppear()
    
    var trainingsOneDay: [Training] { get set }
    var user: User { get set }
}

final class SportPresenter: SportInput {
    
    // MARK: - Properties
    
    weak var view: SportOutput?
    var user = CacheService.loadCache(key: StringKeys.user.rawValue) ?? User.mock
    var trainingAll = CacheService.loadCache(key: StringKeys.allTrainings.rawValue) ?? Training.mock
    var trainingsOneDay = CacheService.loadCache(key: StringKeys.oneDayTrainings.rawValue) ?? Training.mock
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        user = CacheService.loadCache(key: StringKeys.user.rawValue) ?? User.mock
        trainingAll = CacheService.loadCache(key: StringKeys.allTrainings.rawValue) ?? Training.mock
        var newTrainingsOneDay: [Training] = []
        for valueOne in trainingsOneDay{
            for valueAll in trainingAll {
                if valueAll.title == valueOne.title {
                    newTrainingsOneDay.append(valueAll)
                }
            }
        }
        trainingsOneDay = newTrainingsOneDay
        CacheService.saveCache(model: trainingsOneDay, key: StringKeys.oneDayTrainings.rawValue)
    }
}

// MARK: - Private Functions

private extension SportPresenter {

}
