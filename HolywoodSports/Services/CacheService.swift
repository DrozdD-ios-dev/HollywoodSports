//
//  Cache.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import Foundation
import UIKit

enum CacheService {
    
    static func saveCache<T: Encodable>(model: T, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(model) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static func loadCache<T: Decodable>(key: String) -> T? {
        if let savedData = UserDefaults.standard.value(forKey: key) as? Data {
            let decoder = JSONDecoder()
            let savedUser = try? decoder.decode(T.self, from: savedData)
            return savedUser
        }
        return nil
    }
    
    static func saveImageToDirectory(image: UIImage, fileName: String) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let imageData = image.jpegData(compressionQuality: 1) else { return nil }
        do {
            try imageData.write(to: fileURL)
            return fileURL
        } catch {
            return nil
        }
    }
    
    static func loadImageFromURL(url: URL? = nil) -> UIImage {
        do {
            guard let url = url else { return UIImage.Images.imageDefault }
            let imageData = try Data(contentsOf: url)
            let result = UIImage(data: imageData) ?? UIImage.Images.imageDefault
            return result
        } catch {
            return UIImage.Images.imageDefault
        }
    }
}
