//
//  GenderVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import UIKit

protocol GenderOutput: AnyObject {
    
}

final class GenderVC: BaseController {
    
    // MARK: - Views
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.font(type: .poppins600, size: 28)
        label.textAlignment = .center
        label.text = "What’s your gender?"
        return label
    }()
    
    // MARK: - Properties
    
    private var presenter: GenderInput
    private var flag: Bool
    private var buttons = [UIButton]()
    
    // MARK: - Init
    
    init(presenter: GenderInput, flag: Bool) {
        self.presenter = presenter
        self.flag = flag
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupButtons()
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Private Function

private extension GenderVC {
    
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

        presenter.user.gender = Gender.allCases[index]
        UserService.saveUser(user: presenter.user, key: "user")
        
        if flag {
            let vc = WeightAssembly.build(flag: true)
            navigationController?.pushViewController(vc, animated: true)
        } else {
            dismiss(animated: true)
        }
    }
  
}

// MARK: - Actions

extension GenderVC {
    
    @objc func genderButtonTapped(_ sender: UIButton) {
        selectGenderView(index: sender.tag)
    }
    
}

// MARK: - Output

extension GenderVC: GenderOutput {
    
}

// MARK: - Layout

private extension GenderVC {
    
    func addSubviews() {
        view.addSubview(questionLabel)
        buttons.forEach { view.addSubview($0) }
    }
    
    func makeConstraints() {
        
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
