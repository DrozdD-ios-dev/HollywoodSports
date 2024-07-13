//
//  ProfilePresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

// MARK: - Protocol

protocol ProfileInput {
    func viewDidLoad() async
    
    var rows: [String] { get }
}

final class ProfilePresenter: ProfileInput {
    
    // MARK: - Properties
    
    weak var view: ProfileOutput?
    var rows = ["Change your gender", "Change your weigth", "Change your height"]
    
    
    
    // MARK: - Public Functions
    
    @MainActor
    func viewDidLoad() async {
        await getData()
//        view?.reload()
    }
}

// MARK: - Private Functions

private extension ProfilePresenter {
    
    @MainActor
    func getData() async {
//        do {
//            characters = try await NetworkService.fetch()?.results
//        } catch {
//            print("Failed to fetch: \(error)")
//        }
    }
}
