//swiftlint: disable for_where

import UIKit

// MARK: - Protocol

protocol DetailInput {
    func viewDidLoad()
    func backToScreen()
    func removeProgress()
    
    var training: Training { get }
    var backToScreenFlag: Bool { get set }
}

final class DetailPresenter: DetailInput {
    
    // MARK: - Properties
    
    weak var view: DetailOutput?
    private var user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
    private var trainingAll = CacheService.loadCache(key: DefaultKey.allTrainings) ?? Training.mock
    private var currentWeek = CacheService.loadCache(key: DefaultKey.currentWeek) ?? Day.mock
    private var index: Int
    private var startTime: DispatchTime?
    var backToScreenFlag = true
    var training: Training
    
    // MARK: - Init
    
    init(training: Training, index: Int) {
        self.training = training
        self.index = index
    }
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        startTimer()
        updateEventData()
        updateWeek()
    }
    
    func backToScreen() {
        stopTimer()
    }
    
    func removeProgress() {
        trainingAll[training.index].progress = 0
        CacheService.saveCache(model: trainingAll, key: DefaultKey.allTrainings)
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
        
        if resultSeconds > 60.0 {
            let timeInMinute = Int((resultSeconds / 60.0).rounded())
            trainingAll[training.index].progress += timeInMinute
            checkProgress(progress: trainingAll[training.index].progress)
        } else {
            trainingAll[training.index].seconds = resultSeconds
        }
        
        CacheService.saveCache(model: trainingAll, key: DefaultKey.allTrainings)
        self.startTime = nil
    }
    
    func updateEventData() {
        if index == 0, user.showEvent {
            user.showEvent = false
            CacheService.saveCache(model: user, key: DefaultKey.user)
            view?.callAlertVC()
        }
    }
    
    func  checkProgress(progress: Int) {
        if progress >= 100 {
            backToScreenFlag = false
            view?.activateCheckBoxView()
        }
    }
    
    func updateWeek() {
        let currentDay = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        for (index, value) in currentWeek.enumerated() {
            if value.dayNumber == dateFormatter.string(from: currentDay) {
                currentWeek[index].color = "purple-dark"
                currentWeek[index].opacity = 0
            }
        }
        CacheService.saveCache(model: currentWeek, key: DefaultKey.currentWeek)
    }
}
