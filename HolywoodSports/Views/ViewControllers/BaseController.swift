//
//  BaseController.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

class BaseController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported.")
    override convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init()
    }
    
    @available(*, unavailable, message: "Loading this view controller from a nib is unsupported.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.clear
        
        let attributes: [ NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.font(type: .poppins700, size: 16)
        ]
        
        appearance.titleTextAttributes = attributes
        navigationController?.navigationBar.standardAppearance = appearance
    }
}
