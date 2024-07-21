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
        return true
    }
    
    private func openVC() {
        let vc: UIViewController
        if UserDefaults.standard.bool(forKey: DefaultKey.hasOpenedAppBefore) {
            vc = TabBarController()
        } else {
            let startVC = StartVC()
            vc = UINavigationController(rootViewController: startVC)
        }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.overrideUserInterfaceStyle = .dark
        window.makeKeyAndVisible()
        self.window = window
    }
}
