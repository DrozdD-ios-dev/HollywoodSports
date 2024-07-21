//
//  WeightPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import UIKit

// MARK: - Protocol

protocol WeightInput {
    func updateView()
    func nextAction()
    
    var leftValueKg: [Int] { get set }
    var leftValueResult: [Int] { get }
    var centerValueKg: [Int] { get set }
    var centerValueResult: [Int] { get }
    var weightElements: [String] { get }
    var weightType: Weight { get set }
    var result: (Int, Int) { get set }
}

final class WeightPresenter: WeightInput {
    
    // MARK: - Properties
    
    weak var view: WeightOutput?
    private var flag: Bool
    private var user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
    private let indexConvertToLbs = 2.205
    let weightElements = ["kg", "lbs", ""]
    var weightType = Weight.kg
    var result: (Int, Int) = (30, 0)
    var leftValueKg = Array(30...120)
    var centerValueKg = Array(0...9)
    
    var leftValueResult: [Int] {
        return weightType == .kg ? leftValueKg : leftValueKg.map { Int((Double($0) * indexConvertToLbs * 10).rounded() / 10) }
    }
    
    var centerValueResult: [Int] {
        return weightType == .kg ? centerValueKg : centerValueKg.map { Int((Double($0) * indexConvertToLbs * 10).rounded() / 10) }
    }
    
    // MARK: - Init
    
    init(flag: Bool) {
        self.flag = flag
    }
    
    // MARK: - Public Functions
    
    func updateView() {
        if flag {
            view?.updateView()
        }
    }
    
    func nextAction() {
        if flag {
            saveValue()
            view?.nextVC()
        } else {
            saveValue()
            view?.dismiss()
        }
    }
}

// MARK: - Private Functions

private extension WeightPresenter {
    
    func saveValue() {
        user.weight = Double(result.0) + (Double(result.1) / 10)
        user.weightType = weightType
        CacheService.saveCache(model: user, key: DefaultKey.user)
        NotificationCenter.default.post(name: Notification.Name("UpdateUser"), object: nil)
    }
}
