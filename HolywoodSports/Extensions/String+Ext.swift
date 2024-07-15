//
//  String+Ext.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

extension String {
    func convertToImage() -> UIImage? {
        var resultImage = UIImage(named: "image")
           if let imageData = Data(base64Encoded: self),
              let image = UIImage(data: imageData) {
               resultImage = image
           }
        return resultImage
       }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}
