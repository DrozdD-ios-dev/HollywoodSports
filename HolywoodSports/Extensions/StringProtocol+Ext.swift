//
//  StringProtocol+Ext.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
