//
//  AlertVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 19.07.2024.
//

import UIKit

final class AlertVC: BaseController {
    
    // MARK: - Views

    private let upLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins800, size: 34)
        label.text = "Congratulations!"
        label.textAlignment = .center
        return label
    }()
    
    private let leftSecondLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins400, size: 15)
        label.textAlignment = .center
        label.text = "You got "
        label.textColor = .gray153
        return label
    }()
    
    private lazy var rightSecondLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins400, size: 15)
        label.textAlignment = .center
        label.text = "  points to your rank"
        label.textColor = .gray153
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins600, size: 17)
        label.text = "+50"
        label.textAlignment = .center
        return label
    }()

    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftSecondLabel, numberLabel, rightSecondLabel])
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [upLabel, horizontalStack])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        return stack
    }()

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray51
        view.layer.cornerRadius = 23
        return view
    }()
    
    private let doneImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .Icons.donePurple
        return imageView
    }()

    private lazy var doneButton: DefaultButton = {
        let button = DefaultButton(text: "Claim reward")
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private var user = CacheService.loadCache(key: DefaultKey.user) ?? User.mock

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background.withAlphaComponent(0.7)
        setupSettings()
        addSubviews()
        makeConstraints()
        updateUser()
    }
}

// MARK: - Private Function

private extension AlertVC {
    
    func updateUser() {
        user.points += 50
        CacheService.saveCache(model: user, key: DefaultKey.user)
    }
    
    func setupSettings() {
        let gest = UITapGestureRecognizer(target: self, action: #selector(doneButtonTapped))
        view.addGestureRecognizer(gest)
    }
}

// MARK: - Actions

private extension AlertVC {
    
    @objc func doneButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Layout

private extension AlertVC {
    
    func addSubviews() {
        view.addSubview(backgroundView)
        backgroundView.addSubview(doneImage)
        backgroundView.addSubview(verticalStack)
        view.addSubview(doneButton)
    }
    
    func makeConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(backgroundView.snp.width).multipliedBy(0.6)
            make.centerY.equalToSuperview()
        }

        doneImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(27)
        }
    
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(doneButton.snp.width).multipliedBy(0.155)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(doneImage.snp.bottom).offset(10)
        }
    }
}
