//
//  TabBarItem.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

final class TabBarItem: UITabBarItem {
    convenience init(title: String, image: UIImage, selectImage: UIImage) {
        self.init(title: title, image: image, selectedImage: selectImage)
        self.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }
}
