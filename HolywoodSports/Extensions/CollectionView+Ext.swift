// swiftlint: disable force_cast

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else { return UICollectionViewCell() as! T }
        return cell
    }
}
