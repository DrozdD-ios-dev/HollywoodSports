//
//  BaseButton.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

final class LilacButton: UIButton {
    convenience init(text: String, color: UIColor, tint: UIColor) {
        self.init(type: .system)
        
        initEvent()
        backgroundColor = color
        tintColor = tint
        let font = UIFont.systemFont(ofSize: 10)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
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
