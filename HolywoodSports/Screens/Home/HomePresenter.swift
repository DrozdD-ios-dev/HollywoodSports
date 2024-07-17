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
    
//    var characters: [Result]? { get }
}

final class HomePresenter: HomeInput {
    
    // MARK: - Properties
    
    weak var view: HomeOutput?
//    var characters: [Result]?
    
    
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
    
    }
}

// MARK: - Private Functions

private extension HomePresenter {

}
