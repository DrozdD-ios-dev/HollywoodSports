import UIKit

final class TrashButton: UIButton {
    
    convenience init() {
        self.init(type: .system)
        
        let size = 34.0
        frame = CGRect(x: 0, y: 0, width: size, height: size)
        let trashImage = UIImage.Icons.trash
        setImage(trashImage, for: .normal)
        backgroundColor = .background
        layer.cornerRadius = size / 2
    }
}
