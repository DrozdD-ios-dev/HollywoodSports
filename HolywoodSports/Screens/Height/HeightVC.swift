//
//  HeightVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import UIKit

protocol HeightOutput: AnyObject {
    
}

final class HeightVC: BaseController {
    
    // MARK: - Views
    
    private lazy var nextButton: DefaultButton = {
        let button = DefaultButton(text: "Next")
        button.addAction(UIAction { _ in self.nextButtonTapped() }, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private var presenter: HeightInput
    private var flag: Bool
    
    // MARK: - Init
    
    init(presenter: HeightInput, flag: Bool) {
        self.presenter = presenter
        self.flag = flag
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        navigationController?.setNavigationBarHidden(true, animated: true)
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
    }
}

// MARK: - Private Function

private extension HeightVC {
    
  
}

// MARK: - Actions

extension HeightVC {
    
    func nextButtonTapped() {
//        nextOnboardingCell(flag: true)
    }
    
    @objc func backButtonTapped() {
//        nextOnboardingCell(flag: false)
    }
    
}

// MARK: - Output

extension HeightVC: HeightOutput {
    
}

// MARK: - Layout

private extension HeightVC {
    
    func addSubviews() {
//        view.addSubview(nextButton)
//        view.addSubview(progressBar)
//        view.addSubview(onboardingCollectionView)
    }
    
    func makeConstraints() {
//        nextButton.snp.makeConstraints { make in
//            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
//            make.horizontalEdges.equalToSuperview().inset(16)
//            make.height.equalTo(nextButton.snp.width).multipliedBy(0.155)
//        }
//
//        progressBar.snp.makeConstraints { make in
//            make.height.equalTo(5)
//            make.width.equalTo(65)
//            make.centerX.equalToSuperview()
//            make.bottom.equalTo(nextButton.snp.top).offset(-36)
//        }
//
//        onboardingCollectionView.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.horizontalEdges.equalToSuperview()
//            make.bottom.equalTo(progressBar.snp.top).offset(-34)
//        }
    }
    
}
