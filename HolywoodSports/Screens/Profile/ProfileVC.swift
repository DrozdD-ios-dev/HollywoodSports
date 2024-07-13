//
//  ProfileVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

protocol ProfileOutput: AnyObject {
    
}

final class ProfileVC: BaseController {
    
    // MARK: - Views
    
    private let userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
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
    
    // MARK: - Properties
    
    private var presenter: ProfileInput
    private let user = User.mock
    private var userViews = [UserDataView]()
    
    // MARK: - Init
    
    init(presenter: ProfileInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: Colors.background.rawValue)
        addSubviews()
        makeConstraints()
        createViews()
//        Task {
//            await presenter.viewDidLoad()
//        }
    }
}

// MARK: - Private Function

private extension ProfileVC {
    
    func createViews() {
        
        for index in 0...2 {
            let view = UserDataView(title: presenter.rows[index])
            userViews.append(view)
            verticalStack.addArrangedSubview(view)
        }
    }
}

// MARK: - Actions

private extension ProfileVC {
    
    @objc func editButtonTapped() {
        print("Action")
    }
    
}

// MARK: - Output

extension ProfileVC: ProfileOutput {
    
    
}

// MARK: - Layout

private extension ProfileVC {
    
    func addSubviews() {
        view.addSubview(userPhoto)
        view.addSubview(editButton)
//        view.addSubview(userDataView)
        view.addSubview(verticalStack)
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
        
//        userDataView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//            make.horizontalEdges.equalToSuperview().inset(16)
//        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
    
}
