import UIKit

// MARK: - Protocol

protocol ProfileInput {
    func viewWillAppear()
    func nextAction(index: Int)
    func activateSystemAction(index: Int)
    
    var userRows: [String] { get }
    var systemRows: [String] { get }
    var user: User { get set }
    var userViews: [UserDataView] { get set }
    var systemViews: [SystemDataView] { get set }
}

final class ProfilePresenter: ProfileInput {
    
    // MARK: - Properties
    
    weak var view: ProfileOutput?
    var userRows = ["Change your gender", "Change your weigth", "Change your height"]
    var systemRows = ["Rate app", "Privacy policy", "Terms of use", "Contact Us"]
    var user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
    var userViews = [UserDataView]()
    var systemViews = [SystemDataView]()
 
    // MARK: - Public Functions
    
    func viewWillAppear() {
        updateUserData()
    }
    
    func nextAction(index: Int) {
        switch index {
        case 0:
            view?.openGenderVC()
        case 1:
            view?.openWeightVC()
        case 2:
            view?.openHeightVC()
        default:
            break
        }
    }
    
    func activateSystemAction(index: Int) {
        switch index {
        case 0:
            view?.rateAppTapped()
        case 1:
            view?.privacyPolicyTapped()
        case 2:
            view?.termsOfUseTapped()
        case 3:
            view?.contactUsTapped()
        default:
            break
        }
    }
}

// MARK: - Private Functions

private extension ProfilePresenter {
    
    func updateUserData() {
        user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
        userViews[0].configure(with: user.gender.rawValue.firstUppercased)
        userViews[1].configure(with: "\(user.weight) \(user.weightType)")
        userViews[2].configure(with: "\(user.height) \(user.heightType)")
        view?.updateImage()
    }
  
}
