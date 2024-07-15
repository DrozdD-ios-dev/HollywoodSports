//
//  GenderCell.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

final class GenderCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
//    var user = UserService.loadUser(key: KeysString.userProfile.rawValue) ?? UserProfile.def
    
    var action: (() -> Void)?
    
    // MARK: - Views

    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.font(type: .poppins600, size: 28)
        label.textAlignment = .center
        label.text = "What’s your gender?"
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        setupButtons()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Propertiest

var buttons = [UIButton]()

// MARK: - Private function

private extension GenderCell {
    
    func setupButtons() {
        for (index, value) in Gender.allCases.enumerated() {
            let button = UIButton(type: .system)
            button.tintColor = .gray153
            button.backgroundColor = .gray51
            let font = CustomFont.font(type: .poppins700, size: 16)
            let attributes: [NSAttributedString.Key: Any] = [ .font: font as Any ]
            let attributedString = NSAttributedString(string: value.rawValue, attributes: attributes)
            button.setAttributedTitle(attributedString, for: .normal)
            button.layer.cornerRadius = 25
            button.tag = index
            button.addTarget(self, action: #selector(genderButtonTapped(_ :)), for: .touchUpInside)
            buttons.append(button)
        }
    }
    
    func selectGenderView(index: Int) {
        buttons.forEach { $0.backgroundColor = .gray51; $0.tintColor = .gray153 }
        buttons[index].backgroundColor = .purpleDark
        buttons[index].tintColor = .white
        action?()
//        user.gender = Gender.allCases[index]
//        UserService.saveUser(user: user, key: KeysString.userProfile.rawValue)
//        genderUser = user.gender.rawValue.firstUppercased
//        NotificationCenter.default.post(name: Notification.Name("ActivateButton"), object: nil)
    }
}

// MARK: - Public Functions

extension GenderCell {
    
    func configure(controller: @escaping () -> Void) {
        action = controller
    }
}

// MARK: - Actions

private extension GenderCell {
    
    @objc func genderButtonTapped(_ sender: UIButton) {
        selectGenderView(index: sender.tag)
    }
}

// MARK: - Layout

extension GenderCell {
    
    private func addSubviews() {
        contentView.addSubview(questionLabel)
        buttons.forEach { contentView.addSubview($0) }
    }
    
    private func makeConstraints() {
   
        questionLabel.snp.makeConstraints { make in
            let screen = UIScreen.main.bounds.height
            make.top.equalToSuperview().inset(screen > 851 ? 241 : 150)
            make.horizontalEdges.equalToSuperview()
        }
        
        buttons[0].snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(questionLabel.snp.bottom).offset(24)
            make.height.equalTo(99)
        }
        
        buttons[1].snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(buttons[0].snp.bottom).offset(16)
            make.height.equalTo(99)
        }
    }
}
