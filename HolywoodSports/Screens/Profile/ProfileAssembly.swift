import Foundation

struct ProfileAssembly {
    
    static func build() -> ProfileVC {
        let presenter = ProfilePresenter()
        let vc = ProfileVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
