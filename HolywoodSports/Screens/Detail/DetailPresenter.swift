//
//  DetailPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 17.07.2024.
//

import UIKit

// MARK: - Protocol

protocol DetailInput {
    func viewDidLoad()
    
    var trainingAll: [Trainings] { get }
    var trainingForOneDay: [Trainings] { get set }
}

final class DetailPresenter: DetailInput {
    
    // MARK: - Properties
    
    weak var view: DetailOutput?
    let trainingAll = Trainings.mock
    lazy var trainingForOneDay: [Trainings] = trainingAll.shuffled()
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
 
    }
}

// MARK: - Private Functions

private extension DetailPresenter {

}
