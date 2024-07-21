import Foundation

struct HomeAssembly {
    
    static func build() -> HomeVC {
        let presenter = HomePresenter()
        let vc = HomeVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
