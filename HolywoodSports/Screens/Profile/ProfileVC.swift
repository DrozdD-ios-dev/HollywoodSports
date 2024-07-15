//
//  ProfileVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

protocol ProfileOutput: AnyObject {
    func updateImage()
}

final class ProfileVC: BaseController {
    
    // MARK: - Views
    
    private let userPhoto: UIImageView = {
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
        button.addAction(UIAction { _ in self.saveChangesButtonTapped() }, for: .touchUpInside)
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
        addSubviews()
        makeConstraints()
        createViews()
        presenter.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        presenter.updateUserData()
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

private extension ProfileVC {
    
    @objc func changeValue(_ sender: UITapGestureRecognizer) {
        switch sender.view?.tag {
        case 0:
            let vc = GenderAssembly.build(flag: false)
            navigationController?.present(vc, animated: true)
        case 1:
            let vc = WeightAssembly.build(flag: false)
            navigationController?.present(vc, animated: true)
        case 2:
            let vc = HeightAssembly.build(flag: false)
            navigationController?.present(vc, animated: true)
        default:
            break
        }
    }
    @objc func editButtonTapped() {
        let vc = EditPhotoAssembly.build()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func saveChangesButtonTapped() {
        print("Save")
        progressView.configure(with: presenter.user.points)
    }
}

// MARK: - Output

extension ProfileVC: ProfileOutput {
    
    func updateImage() {
        userPhoto.image = presenter.user.image.convertToImage()
    }
  
}

// MARK: - Layout

private extension ProfileVC {
    
    func addSubviews() {
        [userPhoto, editButton, verticalStack, progressView,
         saveChangesButton].forEach { view.addSubview($0) }
    }
    
    func makeConstraints() {
        userPhoto.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalToSuperview()
            make.size.equalTo(143)
        }
        
        editButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(132)
            make.top.equalTo(userPhoto.snp.bottom).offset(16)
            make.height.equalTo(36)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(40)
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

