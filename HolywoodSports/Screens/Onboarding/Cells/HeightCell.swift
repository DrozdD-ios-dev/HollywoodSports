//
//  HeightCell.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

final class HeightCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
//    var user = UserService.loadUser(key: KeysString.userProfile.rawValue) ?? UserProfile.def
    
    // MARK: - Views

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = R.image.backgroundOnboarding()!
        return imageView
    }()
    
    private let signImage: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = R.image.onboarding.gender()!
        return imageView
    }()
    
    private let firstLabel: UILabel = {
        let label = UILabel()
//        label.font = R.font.sourceSerif4Medium(size: 28)!
        label.textAlignment = .center
        label.text = "Your gender"
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
//        label.font = R.font.sfProTextRegular(size: 16)!
//        label.textColor = R.color.grayUs/erDescriptionLabel()!
        label.numberOfLines = 3
        label.textAlignment = .center
        label.text = "It will reveal the balance of your masculine and feminine energy"
        return label
    }()
    
    private let genderStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.alignment = .center
        stack.distribution = .equalCentering
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addSubviews()
        makeConstraints()
        setupGenderStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private function

private extension HeightCell {
    
    func setupGenderStack() {
//        for (index, value) in genderMock.enumerated() {
//            let view = SelectView(
//                title: value.title,
//                image: value.image)
//            view.tag = index
//            let gest = UITapGestureRecognizer(
//                target: self,
//                action: #selector(genderTapped(_:)))
//            view.addGestureRecognizer(gest)
//            genderStack.addArrangedSubview(view)
//            selectViews.append(view)
//        }
    }
    
//    func selectGenderView(index: Int) {
//        selectViews.forEach { $0.genderView.layer.borderColor = R.color.blurView2()?.cgColor }
//        selectViews[index].genderView.layer.borderColor = R.color.magentaLight()?.cgColor
//
//        user.gender = Gender.allCases[index]
//        UserService.saveUser(user: user, key: KeysString.userProfile.rawValue)
//        genderUser = user.gender.rawValue.firstUppercased
//        NotificationCenter.default.post(name: Notification.Name("ActivateButton"), object: nil)
//    }
}

// MARK: - Actions

private extension HeightCell {
    
    @objc func genderTapped(_ sender: UITapGestureRecognizer) {
//        selectGenderView(index: sender.view?.tag ?? 0)
    }
}

// MARK: - Layout

extension HeightCell {
    
    private func addSubviews() {
        [backgroundImage, signImage, firstLabel, secondLabel, genderStack].forEach { contentView.addSubview($0) }
    }
    
    private func makeConstraints() {
   
        backgroundImage.snp.makeConstraints { make in
            make.height.equalTo(498)
            make.horizontalEdges.equalToSuperview()
        }
        
        signImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signImage.snp.bottom).offset(12)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(firstLabel.snp.bottom).offset(14)
        }
        
        genderStack.snp.makeConstraints { make in
            make.top.equalTo(secondLabel.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(60)
        }
    }
}
