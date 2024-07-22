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
    private var trainingAll = CacheService.loadCache(key: DefaultKey.allTrainings) ?? Training.mock
    var user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
    var trainingsOneDay = CacheService.loadCache(key: DefaultKey.oneDayTrainings) ?? Training.mock
    var weekDays = CacheService.loadCache(key: DefaultKey.currentWeek) ?? Day.mock
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        updateCurrentWeek()
        updateDataForCurrentDay()
    }
    
    func viewWillAppear() {
        trainingsOneDay = CacheService.loadCache(key: DefaultKey.oneDayTrainings) ?? Training.mock
        user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
        trainingAll = CacheService.loadCache(key: DefaultKey.allTrainings) ?? Training.mock
        weekDays = CacheService.loadCache(key: DefaultKey.currentWeek) ?? Day.mock
        var newTrainingsOneDay: [Training] = []
        for valueOne in trainingsOneDay {
            for valueAll in trainingAll where valueAll.title == valueOne.title {
                    newTrainingsOneDay.append(valueAll)
            }
        }
        trainingsOneDay = newTrainingsOneDay
        CacheService.saveCache(model: trainingsOneDay, key: DefaultKey.oneDayTrainings)
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
                weekDays[index].opacity = 0.5
            }
        }
        CacheService.saveCache(model: weekDays, key: DefaultKey.currentWeek)
    }
    
    func updateDataForCurrentDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let currentDay = dateFormatter.string(from: Date.now)
        let savedDay = dateFormatter.string(from: user.currentDay)

        if currentDay != savedDay {
            user.showEvent = true
            user.currentDay = Date.now
            CacheService.saveCache(model: user, key: DefaultKey.user)
            let trainingsOneDay: [Training] = {
                return trainingAll.shuffled().dropLast(2)
            }()
            self.trainingsOneDay = trainingsOneDay
            CacheService.saveCache(model: self.trainingsOneDay, key: DefaultKey.oneDayTrainings)
        }
    }
}
