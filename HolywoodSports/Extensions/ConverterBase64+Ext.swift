//
//  ConverterBase64+Ext.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

extension String {
    func convertStringToImage() -> UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return UIImage(named: ImageKeys.defaultImage.rawValue)
        }
        var resultImage = UIImage(data: imageData)
        if resultImage == nil {
            resultImage = UIImage(named: ImageKeys.defaultImage.rawValue)
        }
        return resultImage
    }
}

extension UIImage {
    func convertImageToString() -> String? {
        guard let imageData = self.pngData() else { return nil }
        let base64String = imageData.base64EncodedString(options: .lineLength64Characters)
        return base64String
    }
}
