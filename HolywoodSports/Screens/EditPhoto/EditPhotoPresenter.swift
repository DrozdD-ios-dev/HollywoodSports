//
//  EditPhotoPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

// MARK: - Protocol

protocol EditPhotoInput {
    func viewDidLoad()

    var user: User { get set }
    var isChangedPhoto: Bool { get set }
}

final class EditPhotoPresenter: EditPhotoInput {
    
    // MARK: - Properties
    
    weak var view: EditPhotoOutput?
    var user = CacheService.loadCache(key: "user") ?? User.mock
    var isChangedPhoto = false {
        didSet {
            view?.activateButton()
        }
    }
    
    // MARK: - Public Functions
    
    func viewDidLoad() {
        
    }
}

// MARK: - Private Functions

private extension EditPhotoPresenter {
    
}
