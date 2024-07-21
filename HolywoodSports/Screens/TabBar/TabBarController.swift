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
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarItems()
        setupAppearance()
    }
    
    // MARK: - Private function
    
    private func createTabBarItems() {
        let itemOne = TabBarItem(
            title: "Home",
            image: .Icons.TabBar.home,
            selectImage: .Icons.TabBar.homeSelect
        )
        
        let itemTwo = TabBarItem(
            title: "Sport",
            image: .Icons.TabBar.bolt,
            selectImage: .Icons.TabBar.boltSelect
        )
        
        let itemThree = TabBarItem(
            title: "Profile",
            image: .Icons.TabBar.profile,
            selectImage: .Icons.TabBar.profileSelect
        )
        
        homeVC.tabBarItem = itemOne
        sportVC.tabBarItem = itemTwo
        profileVC.tabBarItem = itemThree
        
        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: sportVC),
            UINavigationController(rootViewController: profileVC)
        ]
    }
    
    private func setupAppearance() {
        let appearance = UITabBarAppearance.setupSettings()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .background
        tabBar.standardAppearance = appearance
        self.additionalSafeAreaInsets.bottom = 5
    }
}
