//
//  ProfileVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

protocol ProfileOutput: AnyObject {
    func updateImage()
    func openGenderVC()
    func openWeightVC()
    func openHeightVC()
}

final class ProfileVC: BaseController {
    
    // MARK: - Views
    
    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var editButton: EditButton = {
        let button = EditButton()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(editButtonTapped))
        button.addGestureRecognizer(gesture)
        return button
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var saveChangesButton: DefaultButton = {
        let button = DefaultButton(text: "Save changes")
        button.addTarget(self, action: #selector(saveChangesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let progressView = ProgressView()
    
    // MARK: - Properties
    
    private var presenter: ProfileInput
    
    // MARK: - Init
    
    init(presenter: ProfileInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        createViews()
        addSubviews()
        makeConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserNotification), name: Notification.Name("UpdateUser"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        presenter.viewWillAppear()
        progressView.configure(with: presenter.user.points)
    }
}

// MARK: - Output

extension ProfileVC: ProfileOutput {
    
    func openGenderVC() {
        let vc = GenderAssembly.build(flag: false)
        navigationController?.present(vc, animated: true)
    }
    
    func openWeightVC() {
        let vc = WeightAssembly.build(flag: false)
        navigationController?.present(vc, animated: true)
    }
    
    func openHeightVC() {
        let vc = HeightAssembly.build(flag: false)
        navigationController?.present(vc, animated: true)
    }
    
    func updateImage() {
        userImage.image = CacheService.loadImageFromURL(url: presenter.user.image)
    }
    
}

// MARK: - Private Function

private extension ProfileVC {
    
    func createViews() {
        for index in 0...2 {
            let view = UserDataView(title: presenter.rows[index])
            view.tag = index
            let gest = UITapGestureRecognizer(target: self, action: #selector(changeValue(_:)))
            view.addGestureRecognizer(gest)
            presenter.userViews.append(view)
            verticalStack.addArrangedSubview(view)
        }
    }
}

// MARK: - Actions

 extension ProfileVC {
    
    @objc func changeValue(_ sender: UITapGestureRecognizer) {
        presenter.nextAction(index: sender.view?.tag ?? 0)
    }
    
    @objc func editButtonTapped() {
        let vc = EditPhotoAssembly.build(flag: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func saveChangesButtonTapped() {
        CacheService.saveCache(model: presenter.user, key: DefaultKey.user)
    }
    
    @objc func updateUserNotification() {
        presenter.viewWillAppear()
    }
}

// MARK: - Layout

private extension ProfileVC {
    
    func addSubviews() {
        [userImage, editButton, verticalStack, progressView,
         saveChangesButton].forEach { view.addSubview($0) }
    }
    
    func makeConstraints() {
        let screen = UIScreen.main.bounds.height
        userImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(screen > 851 ? 80 : 30)
            make.centerX.equalToSuperview()
            make.size.equalTo(143)
        }
        
        editButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(screen > 851 ? 132 : 120)
            make.top.equalTo(userImage.snp.bottom).offset(16)
            make.height.equalTo(36)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(screen > 851 ? 40 : 16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(verticalStack.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(saveChangesButton.snp.width).multipliedBy(0.155)
        }
    }
}
