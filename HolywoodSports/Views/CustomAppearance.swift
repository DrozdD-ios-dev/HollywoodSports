//
//  CustomAppearance.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

struct CustomAppearance {
    static func settingsAppearance() -> UITabBarAppearance {
        let appearance = UITabBarAppearance()
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor(named: Colors.purpleDark.rawValue) as Any]

        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 8)
        
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: Colors.purpleDark.rawValue)
        
        return appearance
    }
}
