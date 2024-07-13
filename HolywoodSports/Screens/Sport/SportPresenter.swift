//
//  SportPresenter.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

// MARK: - Protocol

protocol SportInput {
    func viewDidLoad() async
    
//    var characters: [Result]? { get }
}

final class SportPresenter: SportInput {
    
    // MARK: - Properties
    
    weak var view: SportOutput?
//    var characters: [Result]?
    
    
    
    // MARK: - Public Functions
    
    @MainActor
    func viewDidLoad() async {
        await getData()
        view?.reload()
    }
}

// MARK: - Private Functions

private extension SportPresenter {
    
    @MainActor
    func getData() async {
//        do {
//            characters = try await NetworkService.fetch()?.results
//        } catch {
//            print("Failed to fetch: \(error)")
//        }
    }
}
