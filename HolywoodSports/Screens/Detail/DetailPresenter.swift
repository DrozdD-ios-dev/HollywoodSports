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
    
    var training: Training { get }
}

final class DetailPresenter: DetailInput {
    
    // MARK: - Properties
    
    weak var view: DetailOutput?
    var training: Training
//    let trainingAll = Training.mock
//    lazy var trainingForOneDay: [Training] = trainingAll.shuffled()
    
    // MARK: - Init
    
    init(training: Training) {
        self.training = training
    }
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
 
    }
}

// MARK: - Private Functions

private extension DetailPresenter {

}
