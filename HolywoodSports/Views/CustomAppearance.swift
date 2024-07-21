import UIKit

extension UITabBarAppearance {
    static func setupSettings() -> UITabBarAppearance {
        let appearance = UITabBarAppearance()
        
        appearance.stackedLayoutAppearance.selected.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.purpleDark]
        
        appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 8)
        
        appearance.stackedLayoutAppearance.normal.iconColor = .white
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.purpleDark
        return appearance
    }
}
