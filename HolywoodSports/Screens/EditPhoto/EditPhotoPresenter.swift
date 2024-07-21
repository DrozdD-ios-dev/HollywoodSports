//
//  EditPhotoPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

// MARK: - Protocol

protocol EditPhotoInput {
    func updateView()

    var user: User { get set }
    var isChangedPhoto: Bool { get set }
}

final class EditPhotoPresenter: EditPhotoInput {
    
    // MARK: - Properties
    
    weak var view: EditPhotoOutput?
    private var flag: Bool
    var user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock
    var isChangedPhoto = false {
        didSet {
            view?.activateButton()
        }
    }
    
    // MARK: - Init
    
    init(flag: Bool) {
        self.flag = flag
    }
    
    // MARK: - Public Functions
    
    func updateView() {
        if flag {
            view?.updateViewForAddPhoto()
        } else {
            view?.updateViewForChangePhoto()
        }
    }
}
