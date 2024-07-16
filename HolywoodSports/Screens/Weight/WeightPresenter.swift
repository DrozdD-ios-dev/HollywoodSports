//
//  WeightPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import UIKit

// MARK: - Protocol

protocol WeightInput {
    func viewDidLoad()
    
    var user: User { get set }
    var leftValueKg: [Int] { get set }
    var leftValueResult: [Int] { get }
    var centerValueKg: [Int] { get set }
    var centerValueResult: [Int] { get }
    var weightElements: [String] { get }
    var weightIndex: Weight { get set }
    var result: (Int, Int) { get set }
}

final class WeightPresenter: WeightInput {
    
    // MARK: - Properties
    
    weak var view: WeightOutput?
    var user = UserService.loadUser(key: "user") ?? User.mock
    let weightElements = ["kg", "lbs", ""]
    var weightIndex = Weight.kg
    var result: (Int, Int) = (50, 0)
    var leftValueKg = Array(30...120)
    var centerValueKg = Array(0...9)
    let indexConvertToLbs = 2.205
    
    var leftValueResult: [Int] {
        return weightIndex == .kg ? leftValueKg : leftValueKg.map { Int((Double($0) * indexConvertToLbs * 10).rounded() / 10) }
    }
  
    var centerValueResult: [Int] {
        return weightIndex == .kg ? centerValueKg : centerValueKg.map { Int((Double($0) * indexConvertToLbs * 10).rounded() / 10) }
    }
        
    // MARK: - Public Functions
    
    func viewDidLoad() {
        
    }
}

// MARK: - Private Functions

private extension WeightPresenter {
    
}
