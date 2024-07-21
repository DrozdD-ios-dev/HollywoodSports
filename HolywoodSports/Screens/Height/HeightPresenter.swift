import UIKit

// MARK: - Protocol

protocol HeightInput {
    func updateView()
    func nextAction()
    
    var leftValueKg: [Int] { get set }
    var leftValueResult: [Int] { get }
    var centerValueKg: [Int] { get set }
    var centerValueResult: [Int] { get }
    var heightElements: [String] { get }
    var heightType: Height { get set }
    var result: (Int, Int) { get set }
}

final class HeightPresenter: HeightInput {
    
    // MARK: - Properties
    
    weak var view: HeightOutput?
    private var flag: Bool
    private var user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
    private let indexConvertToFoot = 30.48
    let heightElements = ["cm", "ft/in", ""]
    var heightType = Height.cm
    var result: (Int, Int) = (140, 0)
    var leftValueKg = Array(140...220)
    var centerValueKg = Array(0...9)
    
    var leftValueResult: [Int] {
        return heightType == .cm ? leftValueKg : leftValueKg.map { Int((Double($0) / indexConvertToFoot * 100).rounded() / 100) }
    }
    
    var centerValueResult: [Int] {
        return heightType == .cm ? centerValueKg : centerValueKg.map { Int((Double($0) / indexConvertToFoot * 10).rounded() / 10) }
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

private extension HeightPresenter {
    
    func saveValue() {
        user.height = Double(result.0) + (Double(result.1) / 10)
        user.heightType = heightType
        CacheService.saveCache(model: user, key: DefaultKey.user)
        NotificationCenter.default.post(name: Notification.Name("UpdateUser"), object: nil)
    }
}
