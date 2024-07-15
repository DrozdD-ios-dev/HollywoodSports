//
//  SecondVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

protocol SecondOutput: AnyObject {

}

final class SecondVC: BaseController {
    
    // MARK: - Views
    
    private lazy var updateButton: DefaultButton = {
        let button = DefaultButton(text: "UPDATE NOW")
        button.addAction(UIAction { _ in self.updateButtonTapped() }, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private var presenter: SecondInput
    
    // MARK: - Init
    
    init(presenter: SecondInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
    }
}

// MARK: - Actions

private extension SecondVC {
    
    @objc func updateButtonTapped() {
        print("UPDATE NOW")
    }
    
}

// MARK: - Output

extension SecondVC: SecondOutput {

}

// MARK: - Layout

private extension SecondVC {
    
    func addSubviews() {
        view.addSubview(updateButton)
    }
    
    func makeConstraints() {
        updateButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
    
}

