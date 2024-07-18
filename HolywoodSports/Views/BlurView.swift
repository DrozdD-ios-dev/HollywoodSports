//
//  BlurView.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 18.07.2024.
//

import UIKit

final class BlurView: UIView {
    
    // MARK: - Views
    
    private let purpleLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = .purpleDark
        return view
    }()
    
    private let leftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "time")
        return imageView
    }()
    
    private let purpleRightView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let rightImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "burn")
        return imageView
    }()
    
    private let verticalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray153
        return view
    }()
    
    private let leftTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = CustomFont.font(type: .poppins400, size: 10)
        label.textColor = .gray153
        return label
    }()
    
    private let leftDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Male"
        label.font = CustomFont.font(type: .poppins700, size: 12)
        return label
    }()
    
    private let rightTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Burn"
        label.font = CustomFont.font(type: .poppins400, size: 10)
        label.textColor = .gray153
        return label
    }()
    
    private let rightDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Male"
        label.font = CustomFont.font(type: .poppins700, size: 12)
        return label
    }()
    
    private lazy var horizontalBlurStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    // MARK: - Properties
    
    let blurEffect = UIBlurEffect(style: .prominent)
    lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    let images = ["time", "burn"]
    let systemLabels = ["Time", "Burn"]
    var labels = [UILabel]()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupSettings()
        setupBlurViewSettings()
        addSubviews()
        makeConstraints()
        createViews() 
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        blurEffectView.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Function
    
    func setupBlurViewSettings() {
        blurEffectView.layer.cornerRadius = 15
        blurEffectView.alpha = 0.4
        blurEffectView.clipsToBounds = true
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func setupSettings() {
        backgroundColor = .clear
        layer.cornerRadius = 15
        layer.borderWidth = 0.3
        clipsToBounds = true
        layer.borderColor = UIColor.greenDark.cgColor
    }
    
    func createViews() {
        var flag = true
        for index in 0...1 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: images[index])
            
            let view = UIView()
            view.backgroundColor = .purpleDark
            view.layer.cornerRadius = 5
            view.addSubview(imageView)
            imageView.snp.makeConstraints { $0.center.equalToSuperview() }
            view.snp.makeConstraints { $0.size.equalTo(32) }
            
            let titleLabel = UILabel()
            titleLabel.text = systemLabels[index]
            titleLabel.font = CustomFont.font(type: .poppins400, size: 10)
            titleLabel.textColor = .gray153
            
            let descriptionLabel = UILabel()
            descriptionLabel.text = "20 min"
            descriptionLabel.font = CustomFont.font(type: .poppins700, size: 12)
            
            lazy var verticalStack = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
            verticalStack.axis = .vertical
            verticalStack.alignment = .leading
            verticalStack.spacing = 5
            
            lazy var horizontalStack = UIStackView(arrangedSubviews: [view, verticalStack])
            horizontalStack.axis = .horizontal
            horizontalStack.alignment = .center
            horizontalStack.spacing = 5
            
            labels.append(descriptionLabel)
            horizontalBlurStack.addArrangedSubview(horizontalStack)
            if flag {
                horizontalBlurStack.addArrangedSubview(verticalLineView)
                flag = false
            }
        }
    }
    
    // MARK: - Public Functions
    
    func configure(with model: Training) {
        labels[0].text = "\(model.time) min"
        labels[1].text = "\(model.kcal) kcal"
    }
}

// MARK: - Layout

private extension BlurView {
    
    func addSubviews() {
        addSubview(horizontalBlurStack)
    }
    
    func makeConstraints() {

        horizontalBlurStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        verticalLineView.snp.makeConstraints { make in
            make.width.equalTo(1)
        }
    }
}

