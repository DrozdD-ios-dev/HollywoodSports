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
    func backToScreen()
    func removeProgress()
    
    var training: Training { get }
    var user: User { get set }
    var backToScreenFlag: Bool { get set }
}

final class DetailPresenter: DetailInput {
    
    // MARK: - Properties
    
    weak var view: DetailOutput?
    var training: Training
    var user = CacheService.loadCache(key: StringKeys.user.rawValue) ?? User.mock
    var trainingAll = CacheService.loadCache(key: StringKeys.allTrainings.rawValue) ?? Training.mock
    var index: Int
    var startTime: DispatchTime?
    var backToScreenFlag = true
    
    // MARK: - Init
    
    init(training: Training, index: Int) {
        self.training = training
        self.index = index
    }
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        startTimer()
        updateEventData()
    }
    
    func backToScreen() {
        stopTimer()
    }
    
    func removeProgress() {
        trainingAll[training.index].progress = 0
        CacheService.saveCache(model: trainingAll, key: StringKeys.allTrainings.rawValue)
    }
}

// MARK: - Private Functions

private extension DetailPresenter {
    
    func startTimer() {
        startTime = DispatchTime.now()
    }
    
    func stopTimer() {
        guard let startTime = startTime else { return }
        
        let endTime = DispatchTime.now()
        let nanoTime = endTime.uptimeNanoseconds - startTime.uptimeNanoseconds
        let timeInterval = Double(nanoTime) / 1_000_000_000
        let resultSeconds = timeInterval + trainingAll[training.index].seconds
        
        #warning("5 of 60!!!")
        if resultSeconds > 5.0 {
            let timeInMinute = Int((resultSeconds / 5.0).rounded())
            trainingAll[training.index].progress += timeInMinute
            checkProgress(progress: trainingAll[training.index].progress)
        } else {
            trainingAll[training.index].seconds = resultSeconds
        }
        
        CacheService.saveCache(model: trainingAll, key: StringKeys.allTrainings.rawValue)
        self.startTime = nil
    }
    
    func updateEventData() {
        if index == 0, user.showEvent {
            user.showEvent = false
            user.currentDay = CheckDateService.currentDay()
            #warning("Сделать алерт и +50 поинтов")
            user.points += 50
            CacheService.saveCache(model: user, key: StringKeys.user.rawValue)
        }
    }
    
    func  checkProgress(progress: Int) {
        if progress >= 100 {
            backToScreenFlag = false
            view?.activateCheckBoxView()
        }
    }
}
