//
//  DetailVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 17.07.2024.
//

import UIKit

protocol DetailOutput: AnyObject {
    func activateCheckBoxView()
}

final class DetailVC: BaseController {
    
    // MARK: - Views
    
    private let trainingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.font(type: .poppins800, size: 24)
        label.textAlignment = .left
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.font(type: .poppins400, size: 15)
        label.textAlignment = .left
        label.numberOfLines = 5
        label.textColor = .gray153
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [trainingImage, titleLabel, descriptionLabel, horizontalLine, checkBoxView])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        return stack
    }()
    
    private let horizontalLine: UIView = {
        let line = UIView()
        line.backgroundColor = .gray51
        return line
    }()
    
    private let checkBoxView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray51
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let checkBoxImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let checkBoxDoneCircleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "done")
        imageView.isHidden = true
        return imageView
    }()
    
    private let checkBoxTitleLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.font(type: .poppins500, size: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let checkBoxDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.font(type: .poppins400, size: 13)
        label.textAlignment = .left
        label.numberOfLines = 5
        label.textColor = .gray153
        return label
    }()
    
    private lazy var checkBoxVerticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [checkBoxTitleLabel, checkBoxDescriptionLabel])
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .leading
        return stack
    }()
    
    private let checkBoxCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 9
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray153.cgColor
        return view
    }()
    
    private lazy var doneButton: DefaultButton = {
        let button = DefaultButton(text: "Done")
        button.addAction(UIAction { _ in self.doneButtonTapped() }, for: .touchUpInside)
        button.alpha = 0.3
        button.isEnabled = false
        return button
    }()
    
    private lazy var blurView = BlurView()
    
    private lazy var backButton: CircularBackButton = {
        let button = CircularBackButton()
        button.addAction(UIAction { _ in self.backButtonTapped() }, for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    private var presenter: DetailInput
    
    // MARK: - Init
    
    init(presenter: DetailInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupSettings()
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
        updateView()
    }
}

// MARK: - Private Function

private extension DetailVC {
    
    func setupSettings() {
        view.backgroundColor = .background
        tabBarController?.tabBar.isHidden = true
        navigationItem.title = "Workout"
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    func updateView() {
        titleLabel.text = presenter.training.title
        descriptionLabel.text = presenter.training.description
        trainingImage.image = UIImage(named: presenter.training.imageName)
        checkBoxImage.image = UIImage(named: presenter.training.imageName)
        checkBoxTitleLabel.text = presenter.training.title
        checkBoxDescriptionLabel.text = presenter.training.miniDescription
        blurView.configure(with: presenter.training)
    }
}

// MARK: - Actions

private extension DetailVC {
    
    @objc func backButtonTapped() {
        presenter.backToScreen()
        if presenter.backToScreenFlag {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func doneButtonTapped() {
        print("Done")
#warning("Сделать алерт и +50 поинтов")
        presenter.user.points += 50
        CacheService.saveCache(model: presenter.user, key: StringKeys.user.rawValue)
        presenter.removeProgress()
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Output

extension DetailVC: DetailOutput {
    
    func activateCheckBoxView() {
        checkBoxCircleView.backgroundColor = .purpleBlue
        checkBoxCircleView.layer.borderWidth = 0
        checkBoxDoneCircleImage.isHidden = false
        doneButton.isEnabled = true
        doneButton.alpha = 1
    }
}

// MARK: - Layout

private extension DetailVC {
    
    func addSubviews() {
        [verticalStack, doneButton].forEach { view.addSubview($0) }
        checkBoxView.addSubview(checkBoxImage)
        checkBoxView.addSubview(checkBoxVerticalStack)
        checkBoxView.addSubview(checkBoxCircleView)
        checkBoxCircleView.addSubview(checkBoxDoneCircleImage)
        view.addSubview(blurView)
    }
    
    func makeConstraints() {
        let screen = UIScreen.main.bounds.height
        trainingImage.snp.makeConstraints { make in
            make.height.equalTo(screen > 851 ? 250 : 210)
            make.width.equalToSuperview()
        }
        
        horizontalLine.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        
        checkBoxView.snp.makeConstraints { make in
            make.height.equalTo(screen > 851 ? 99 : 80)
            make.width.equalToSuperview()
        }
        
        verticalStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(screen > 851 ? 60 : 30)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(screen > 851 ? 20 : 10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(doneButton.snp.width).multipliedBy(0.155)
        }
        
        checkBoxImage.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(11)
            make.width.equalTo(81)
        }
        
        checkBoxVerticalStack.snp.makeConstraints { make in
            make.leading.equalTo(checkBoxImage.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
        }
        
        checkBoxCircleView.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.top.trailing.equalToSuperview().inset(13)
        }
        
        checkBoxDoneCircleImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        blurView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(trainingImage.snp.top).offset(32)
            make.width.equalTo(trainingImage.snp.width).multipliedBy(0.73)
            make.height.equalTo(64)
        }
    }
}

