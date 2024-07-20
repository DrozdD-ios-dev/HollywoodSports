//
//  HomePresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//
//swiftlint: disable for_where

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
        weekDays = CacheService.loadCache(key: StringKeys.currentWeek.rawValue) ?? Day.mock
        var newTrainingsOneDay: [Training] = []
        for valueOne in trainingsOneDay {
            for valueAll in trainingAll where valueAll.title == valueOne.title {
                    newTrainingsOneDay.append(valueAll)
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
        let currentWeekDates = DateService.datesForCurrentWeek()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        for (index, value) in currentWeekDates.enumerated() {
            if weekDays[index].dayNumber != dateFormatter.string(from: value) {
                weekDays[index].dayNumber = dateFormatter.string(from: value)
                weekDays[index].color = "gray-51"
            }
        }
        CacheService.saveCache(model: weekDays, key: StringKeys.currentWeek.rawValue)
    }
    
    func updateDataForCurrentDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let currentDay = dateFormatter.string(from: Date.now)
        let savedDay = dateFormatter.string(from: user.currentDay)

        if currentDay != savedDay {
            user.showEvent = true
            CacheService.saveCache(model: user, key: StringKeys.user.rawValue)
            let trainingsOneDay: [Training] = {
                return trainingAll.shuffled().dropLast(2)
            }()
            self.trainingsOneDay = trainingsOneDay
            CacheService.saveCache(model: self.trainingsOneDay, key: StringKeys.oneDayTrainings.rawValue)
        }
    }
}
