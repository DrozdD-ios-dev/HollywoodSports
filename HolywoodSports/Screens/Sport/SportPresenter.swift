import UIKit

// MARK: - Protocol

protocol SportInput {
    func viewWillAppear()
    
    var trainingsOneDay: [Training] { get set }
    var user: User { get set }
}

final class SportPresenter: SportInput {
    
    // MARK: - Properties
    
    weak var view: SportOutput?
    private var trainingAll = CacheService.loadCache(key: DefaultKey.allTrainings) ?? Training.mock
    var user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
    var trainingsOneDay = CacheService.loadCache(key: DefaultKey.oneDayTrainings) ?? Training.mock
    
    // MARK: - Public Functions
    
    func viewWillAppear() {
        trainingsOneDay = CacheService.loadCache(key: DefaultKey.oneDayTrainings) ?? Training.mock
        user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
        trainingAll = CacheService.loadCache(key: DefaultKey.allTrainings) ?? Training.mock
        var newTrainingsOneDay: [Training] = []
        for valueOne in trainingsOneDay {
            for valueAll in trainingAll where valueAll.title == valueOne.title {
                    newTrainingsOneDay.append(valueAll)
            }
        }
        trainingsOneDay = newTrainingsOneDay
        CacheService.saveCache(model: trainingsOneDay, key: DefaultKey.oneDayTrainings)
    }
}
