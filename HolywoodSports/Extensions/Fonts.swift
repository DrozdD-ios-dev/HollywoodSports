import UIKit

extension UIFont {
    enum FontType: String {
        case poppins400   = "Poppins-Regular"
        case poppins500   = "Poppins-Medium"
        case poppins600   = "Poppins-SemiBold"
        case poppins700   = "Poppins-Bold"
        case poppins800   = "Poppins-ExtraBold"
    }
    
    static func font(type: FontType, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
