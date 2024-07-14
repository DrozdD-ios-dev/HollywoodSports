//
//  CircularBackButton.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

final class CircularBackButton: UIButton {
    
    convenience init() {
        self.init(type: .system)
        
        let size = 45.0
        frame = CGRect(x: 0, y: 0, width: size, height: size)
        let chevronImage = UIImage(systemSymbol: .chevronLeft)
        setImage(chevronImage, for: .normal)
        backgroundColor = .gray51
        tintColor = .white
        layer.cornerRadius = size / 2
    }
}
