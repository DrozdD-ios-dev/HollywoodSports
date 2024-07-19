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
        setupCountApp()
        return true
    }
    
    func setupCountApp() {
        if UserDefaults.standard.integer(forKey: "first") == 0 {
            UserDefaults.standard.set(1, forKey: "first")
        } else {
            if UserDefaults.standard.integer(forKey: "first") >= 1 {
                var count = UserDefaults.standard.integer(forKey: "first")
                count += 1
                UserDefaults.standard.set("\(count)", forKey: "first")
            }
        }
    }
    
    private func openVC() {
        var vc = UIViewController()
        
        if UserDefaults.standard.integer(forKey: "first") == 0 {
//            let user = User.mock
//            CacheService.saveCache(model: user, key: StringKeys.user.rawValue)
            vc = UINavigationController(rootViewController: OnboardingAssembly.build())
        } else {
            vc = TabBarController()
        }
        
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

