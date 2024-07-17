//
//  TabBarController.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private let homeVC = HomeAssembly.build()
    private let sportVC = SportAssembly.build()
    private let profileVC = ProfileAssembly.build()
    
    // MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarItems()
        setupAppearance()
    }
    
    // MARK: - private func
    
    private func createTabBarItems() {
        let itemOne = TabBarItem(
            title: "Home",
            image: UIImage(named: "home") ?? UIImage.actions,
            selectImage:  UIImage(named: "home.select") ?? UIImage.actions
        )
        
        let itemTwo = TabBarItem(
            title: "Sport",
            image: UIImage(named: "bolt") ?? UIImage.actions, 
            selectImage: UIImage(named: "bolt.select") ?? UIImage.actions
        )
        
        let itemThree = TabBarItem(
            title: "Profile",
            image: UIImage(named: "profile") ?? UIImage.actions,
            selectImage: UIImage(named: "profile.select") ?? UIImage.actions
        )
        
        homeVC.tabBarItem = itemOne
        sportVC.tabBarItem = itemTwo
        profileVC.tabBarItem = itemThree
        
        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: sportVC),
            UINavigationController(rootViewController: profileVC),
        ]
    }
    
    private func setupAppearance() {
        let appearance = CustomAppearance.settingsAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .background
        tabBar.standardAppearance = appearance
        self.additionalSafeAreaInsets.bottom = 5
    }
}
