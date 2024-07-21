import Foundation

struct SportAssembly {
    
    static func build() -> SportVC {
        let presenter = SportPresenter()
        let vc = SportVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
