//
//  HeightPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import UIKit

// MARK: - Protocol

protocol HeightInput {
    func viewDidLoad()
    
    var user: User { get set }
    var leftValueKg: [Int] { get set }
    var leftValueResult: [Int] { get }
    var centerValueKg: [Int] { get set }
    var centerValueResult: [Int] { get }
    var heightElements: [String] { get }
    var heightIndex: Height { get set }
    var result: (Int, Int) { get set }
}

final class HeightPresenter: HeightInput {
    
    // MARK: - Properties
    
    weak var view: HeightOutput?
    var user = UserService.loadUser(key: "user") ?? User.mock
    let heightElements = ["cm", "ft/in", ""]
    var heightIndex = Height.cm
    var result: (Int, Int) = (50, 0)
    var leftValueKg = Array(140...220)
    var centerValueKg = Array(0...9)
    let indexConvertToFoot = 30.48
    
    var leftValueResult: [Int] {
        return heightIndex == .cm ? leftValueKg : leftValueKg.map { Int((Double($0) / indexConvertToFoot * 100).rounded() / 100) }
    }
  
    var centerValueResult: [Int] {
        return heightIndex == .cm ? centerValueKg : centerValueKg.map { Int((Double($0) / indexConvertToFoot * 10).rounded() / 10) }
    }
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        
    }
}

// MARK: - Private Functions

private extension HeightPresenter {
    
}
