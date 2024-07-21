import Foundation

struct EditPhotoAssembly {
    
    static func build(flag: Bool) -> EditPhotoVC {
        let presenter = EditPhotoPresenter(flag: flag)
        let vc = EditPhotoVC(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
