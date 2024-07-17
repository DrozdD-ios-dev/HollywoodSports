//
//  DetailVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 17.07.2024.
//

import UIKit

protocol DetailOutput: AnyObject {
    
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
        return button
    }()
    
    private lazy var blurView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.greenDark.cgColor
        return view
    }()
    
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
        test()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupBlurViewSettings()
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
    
    func setupBlurViewSettings() {
        let blurEffect = UIBlurEffect(style: .prominent)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.cornerRadius = 15
        blurEffectView.frame = blurView.bounds
        blurEffectView.alpha = 0.8
        blurEffectView.clipsToBounds = true
        blurView.addSubview(blurEffectView)
    }
    
    func test() {
        let training = Trainings.mock
        titleLabel.text = training[0].title
        descriptionLabel.text = training[0].description
        trainingImage.image = training[0].image
        
        checkBoxImage.image = training[0].image
        checkBoxTitleLabel.text = training[0].title
        checkBoxDescriptionLabel.text = training[0].miniDescription
    }
    
    func activateCheckBoxView() {
        checkBoxCircleView.backgroundColor = .purpleBlue
        checkBoxCircleView.layer.borderWidth = 0
        checkBoxDoneCircleImage.isHidden = false
    }
}

// MARK: - Actions

private extension DetailVC {
    
    @objc func backButtonTapped() {
//        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func doneButtonTapped() {
        print("Done")
        activateCheckBoxView()
    }
}

// MARK: - Output

extension DetailVC: DetailOutput {
  
}

// MARK: - Layout

private extension DetailVC {
    
    func addSubviews() {
        [verticalStack, doneButton].forEach { view.addSubview($0) }
        checkBoxView.addSubview(checkBoxImage)
        checkBoxView.addSubview(checkBoxVerticalStack)
        checkBoxView.addSubview(checkBoxCircleView)
        checkBoxCircleView.addSubview(checkBoxDoneCircleImage)
        trainingImage.addSubview(blurView)
    }
    
    func makeConstraints() {
        trainingImage.snp.makeConstraints { make in
            make.height.equalTo(trainingImage.snp.width).multipliedBy(0.65)
            make.width.equalToSuperview()
        }
        
        horizontalLine.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(1)
        }
        
        checkBoxView.snp.makeConstraints { make in
            make.height.equalTo(checkBoxView.snp.width).multipliedBy(0.27)
            make.width.equalToSuperview()
        }
        
        verticalStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(60)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
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
            make.width.equalTo(263)
            make.height.equalTo(64)
        }
    }
}

