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
    
//    private func setupDefaultUsers() {
//        if UserDefaults.standard.object(forKey: "firstSetup") == nil {
            
//        }
//    }
    
    private func openVC() {
        var vc = UIViewController()
//        if UserDefaults.standard.object(forKey: "user") == nil {
//            let user = User.mock
//            CacheService.saveCache(user: user, key: "user")
//            vc = UINavigationController(rootViewController: OnboardingAssembly.build())
//        } else {
            vc = TabBarController()
//        }
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = vc
        window.overrideUserInterfaceStyle = .dark
        window.makeKeyAndVisible()
        self.window = window
    }
    
//    private func setupRemoteSettings() {
//        let remoteConfig = RemoteConfig.remoteConfig()
//        let settings = RemoteConfigSettings()
//        settings.minimumFetchInterval = 0
//        remoteConfig.configSettings = settings
//        remoteConfig.fetchAndActivate { status, error in
//            if error != nil {
//                print(error?.localizedDescription as Any)
//                self.openVC(parameter: false)
//            } else {
//                if status != .error {
//                    let result = remoteConfig.configValue(forKey: "1needForceUpdate")
//                    self.openVC(parameter: result.boolValue)
//                }
//            }
//        }
//    }
    
//    private func openVC(parameter: Bool) {
//        var vc = UIViewController()
//        if parameter {
////            vc = ThirdAssembly.build()
//        } else {
////            vc = TabBarController()
//        }
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.rootViewController = vc
//        window.overrideUserInterfaceStyle = .light
//        window.makeKeyAndVisible()
//        self.window = window
//    }
}

