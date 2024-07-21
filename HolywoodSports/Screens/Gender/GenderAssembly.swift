import Foundation

struct GenderAssembly {
    
    static func build(flag: Bool) -> GenderVC {
        let presenter = GenderPresenter(flag: flag)
        let vc = GenderVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
