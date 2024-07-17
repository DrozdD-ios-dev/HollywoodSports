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
    
    var trainingAll: [Trainings] { get }
    var trainingForOneDay: [Trainings] { get set }
    var user: User { get set }
}

final class SportPresenter: SportInput {
    
    // MARK: - Properties
    
    weak var view: SportOutput?
    var user: User = CacheService.loadCache(key: "user") ?? User.mock
    let trainingAll = Trainings.mock
    lazy var trainingForOneDay: [Trainings] = trainingAll.shuffled()
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        let userNew = CacheService.loadCache(key: "user") ?? User.mock
        user = userNew
    }
}

// MARK: - Private Functions

private extension SportPresenter {

}
