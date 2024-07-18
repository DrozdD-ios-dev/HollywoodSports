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
    func viewWillAppear()
    
    var user: User { get }
    var trainingsOneDay: [Training] { get set }
    var weekDays: [Day] { get set }
}

final class HomePresenter: HomeInput {
    
    // MARK: - Properties
    
    weak var view: HomeOutput?
    var user = CacheService.loadCache(key: StringKeys.user.rawValue) ?? User.mock
    var trainingAll = CacheService.loadCache(key: StringKeys.allTrainings.rawValue) ?? Training.mock
    var trainingsOneDay = CacheService.loadCache(key: StringKeys.oneDayTrainings.rawValue) ?? Training.mock
    var weekDays = CacheService.loadCache(key: StringKeys.currentWeek.rawValue) ?? Day.mock
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        updateCurrentWeek()
        updateDataForCurrentDay()
    }
    
    func viewWillAppear() {
        user = CacheService.loadCache(key: StringKeys.user.rawValue) ?? User.mock
        trainingAll = CacheService.loadCache(key: StringKeys.allTrainings.rawValue) ?? Training.mock
        var newTrainingsOneDay: [Training] = []
        for valueAll in trainingAll {
            for valueOne in trainingsOneDay {
                if valueAll.title == valueOne.title {
                    newTrainingsOneDay.append(valueAll)
                }
            }
        }
        
        trainingsOneDay = newTrainingsOneDay
        CacheService.saveCache(model: trainingsOneDay, key: StringKeys.oneDayTrainings.rawValue)
        view?.updateImage()
    }
}

// MARK: - Private Functions

private extension HomePresenter {
    
    func updateCurrentWeek() {
        let currentWeekDates = CheckDateService.datesForCurrentWeek()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        for (index, value) in currentWeekDates.enumerated() {
            if weekDays[index].dayNumber != dateFormatter.string(from: value) {
                weekDays[index].dayNumber = dateFormatter.string(from: value)
                weekDays[index].color = "gray51"
                CacheService.saveCache(model: weekDays, key: StringKeys.currentWeek.rawValue)
            }
        }
    }
    
    func updateDataForCurrentDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let currentDay = dateFormatter.string(from: CheckDateService.currentDay())
        let savedDay = dateFormatter.string(from: user.currentDay)

        #warning("!=   !!!")
        if currentDay == savedDay {
            user.showEvent = true
            CacheService.saveCache(model: user, key: StringKeys.user.rawValue)
            
            let trainingsOneDay: [Training] = {
                return trainingAll.shuffled().dropLast(2)
            }()
            
            self.trainingsOneDay = trainingsOneDay
            dump(trainingsOneDay)
            CacheService.saveCache(model: trainingsOneDay, key: StringKeys.oneDayTrainings.rawValue)
        }
    }
}
