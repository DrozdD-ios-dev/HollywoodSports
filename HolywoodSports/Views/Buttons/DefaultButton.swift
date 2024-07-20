//
//  DefaultButton.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

final class DefaultButton: UIButton {
    convenience init(text: String) {
        self.init(type: .system)
        
        initEvent()
        backgroundColor = .purpleDark
        tintColor = .white
        let font = UIFont.font(type: .poppins700, size: 16)
        
        let shadow = NSShadow()
             shadow.shadowColor = UIColor.black
             shadow.shadowOffset = CGSize(width: 0, height: 2)
             shadow.shadowBlurRadius = 1
             
             let attributes: [NSAttributedString.Key: Any] = [
                 .font: font as Any,
                 .shadow: shadow
             ]
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        setAttributedTitle(attributedString, for: .normal)
        layer.cornerRadius = 28
    }
    
    private func initEvent() {
        addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
    }
    
    @objc private func buttonPressed() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.7
        }
    }
    
    @objc private func buttonReleased() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1.0
        }
    }
}
