//
//  EditPhotoVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

protocol EditPhotoOutput: AnyObject {
    func activateButton()
}

final class EditPhotoVC: BaseController {
    
    // MARK: - Views
    
    private lazy var backButton: CircularBackButton = {
        let button = CircularBackButton()
        button.addAction(UIAction { _ in self.backButtonTapped() }, for: .touchUpInside)
        return button
    }()
    
    private lazy var userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addPhotoButtonTapped))
        imageView.addGestureRecognizer(gesture)
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = CustomFont.font(type: .poppins600, size: 28)
        return label
    }()
    
    private lazy var saveChangesButton: DefaultButton = {
        let button = DefaultButton(text: "Save changes")
        button.addAction(UIAction { _ in self.saveChangesButtonTapped() }, for: .touchUpInside)
        button.isEnabled = false
        button.isHidden = true
        button.alpha = 0.3
        return button
    }()
    
    private lazy var nextButton: DefaultButton = {
        let button = DefaultButton(text: "Next")
        button.addAction(UIAction { _ in self.nextButtonTapped() }, for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.addAction(UIAction { _ in self.nextButtonTapped() }, for: .touchUpInside)
        let font = CustomFont.font(type: .poppins700, size: 16)
        let attributes: [NSAttributedString.Key: Any] = [ .font: font as Any ]
        let attributedString = NSAttributedString(string: "Skip", attributes: attributes)
        button.tintColor = .white
        button.setAttributedTitle(attributedString, for: .normal)
        button.isHidden = true
        return button
    }()
    
    private lazy var trashButton: TrashButton = {
        let button = TrashButton()
        button.tintColor = .redLight
        button.addAction(UIAction { _ in self.trashButtonTapped() }, for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let progressView = ProgressView()
    
    // MARK: - Properties
    
    private var presenter: EditPhotoInput
    private var flag: Bool
    
    // MARK: - Init
    
    init(presenter: EditPhotoInput, flag: Bool) {
        self.presenter = presenter
        self.flag = flag
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
        updateImage()
        updateView()
    }
}

// MARK: - Private Function

private extension EditPhotoVC {
 
    func setupSettings() {
        view.backgroundColor = .background
        tabBarController?.tabBar.isHidden = true
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    func updateView() {
        if flag {
            descriptionLabel.text = "Add your profile \nphoto"
            nextButton.isHidden = false
            skipButton.isHidden = false
            trashButton.isHidden = false
        } else {
            descriptionLabel.text = "Change your profile \nphoto"
            saveChangesButton.isHidden = false
        }
    }
    
    func updateImage() {
        userPhoto.image = presenter.user.image.convertToImage()
    }
}

// MARK: - Actions

private extension EditPhotoVC {

    @objc func saveChangesButtonTapped() {
        CacheService.saveCache(user: presenter.user, key: "user")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonTapped() {
        CacheService.saveCache(user: presenter.user, key: "user")
        skipButtonTapped()
    }
    
    @objc func skipButtonTapped() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        let vc = TabBarController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func trashButtonTapped() {
        userPhoto.image = UIImage(named: "image")
        presenter.user.image = ""
    }
    
    @objc private func addPhotoButtonTapped() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: - Output

extension EditPhotoVC: EditPhotoOutput {
    
    func activateButton() {
        saveChangesButton.isEnabled = true
        saveChangesButton.alpha = 1
    }
}

// MARK: - Layout

private extension EditPhotoVC {
    
    func addSubviews() {
        [userPhoto, descriptionLabel, saveChangesButton, skipButton, nextButton].forEach { view.addSubview($0) }
        userPhoto.addSubview(trashButton)
    }
    
    func makeConstraints() {
        userPhoto.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(88)
            make.center.equalToSuperview()
            make.height.equalTo(214)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(userPhoto.snp.top).offset(-25)
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(nextButton.snp.width).multipliedBy(0.155)
        }
        
        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(nextButton.snp.width).multipliedBy(0.155)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(skipButton.snp.top)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(nextButton.snp.width).multipliedBy(0.155)
        }
        
        trashButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
            make.size.equalTo(34)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension EditPhotoVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
    
                if let imageData = selectedImage.pngData() {
                    let imageBase64String = imageData.base64EncodedString()
                    presenter.user.image = imageBase64String
                    userPhoto.image = selectedImage
                    presenter.isChangedPhoto = true
                }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
