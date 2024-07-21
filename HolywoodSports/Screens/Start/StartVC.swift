//
//  StartVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

final class StartVC: BaseController {
    
    // MARK: - Views
    
    private let ballImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .Images.ball
        return imageView
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Hollywood"
        label.textAlignment = .center
        label.font = .font(type: .poppins700, size: 47)
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "sports"
        label.textAlignment = .right
        label.textColor = .yellowMiddle
        label.font = .font(type: .poppins700, size: 47)
        return label
    }()
    
    private lazy var startedButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.tintColor = .purpleFirstScreen
        let font = UIFont.font(type: .poppins700, size: 16)
        let attributes: [NSAttributedString.Key: Any] = [ .font: font as Any ]
        let attributedString = NSAttributedString(string: "Get Started",
                                                  attributes: attributes)
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 28
        button.addTarget(self, action: #selector(startedButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purpleFirstScreen
        addSubviews()
        makeConstraints()
    }
}

// MARK: - Actions

private extension StartVC {
    
    @objc func startedButtonTapped() {
        let vc = OnboardingVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Layout

private extension StartVC {
    
    func addSubviews() {
        view.addSubview(ballImage)
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(startedButton)
    }
    
    func makeConstraints() {
        ballImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(195)
            make.centerX.equalToSuperview()
            make.height.equalTo(144)
            make.width.equalTo(143)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.top.equalTo(ballImage.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(67)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).inset(20)
            make.horizontalEdges.equalToSuperview().inset(67)
        }

        startedButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
    
}
