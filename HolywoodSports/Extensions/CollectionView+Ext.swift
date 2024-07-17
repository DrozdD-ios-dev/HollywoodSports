//
//  CollectionView+Ext.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 17.07.2024.
//

import UIKit

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else { return UICollectionViewCell() as! T }
        return cell
    }
}
