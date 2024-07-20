//
//  AppDelegate.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit
import SnapKit
import SFSafeSymbols

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        openVC()
        updateCountApp()
        return true
    }
    
    func updateCountApp() {
        if UserDefaults.standard.integer(forKey: StringKeys.first.rawValue) == 0 {
            UserDefaults.standard.set(1, forKey: StringKeys.first.rawValue)
        } else {
            if UserDefaults.standard.integer(forKey: StringKeys.first.rawValue) >= 1 {
                var count = UserDefaults.standard.integer(forKey: StringKeys.first.rawValue)
                count += 1
                UserDefaults.standard.set("\(count)", forKey: StringKeys.first.rawValue)
            }
        }
    }
    
    private func openVC() {
        let vc: UIViewController
        if UserDefaults.standard.integer(forKey: StringKeys.first.rawValue) == 0 {
            vc = UINavigationController(rootViewController: StartVC())
        } else {
            vc = TabBarController()
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.overrideUserInterfaceStyle = .dark
        window.makeKeyAndVisible()
        self.window = window
    }
}
