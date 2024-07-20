//
//  BlurView.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 18.07.2024.
//

import UIKit

final class BlurView: UIView {
    
    // MARK: - Views
    
    private lazy var horizontalBlurStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    // MARK: - Properties
    
    let blurEffect = UIBlurEffect(style: .prominent)
    lazy var blurEffectView = UIVisualEffectView(effect: blurEffect)
    let images = [UIImage.Icons.time, UIImage.Icons.burn]
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
}

// MARK: - Public Functions

extension BlurView {
    
    func configure(with model: Training) {
        labels[0].text = "\(model.time) min"
        labels[1].text = "\(model.kcal) kcal"
    }
}

// MARK: - Private Function

private extension BlurView {
    
    func setupBlurViewSettings() {
        blurEffectView.layer.cornerRadius = 15
        blurEffectView.alpha = 0.4
        blurEffectView.clipsToBounds = true
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
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
            imageView.image = images[index]
            
            let view = UIView()
            view.backgroundColor = .purpleDark
            view.layer.cornerRadius = 5
            view.addSubview(imageView)
            imageView.snp.makeConstraints { $0.center.equalToSuperview() }
            view.snp.makeConstraints { $0.size.equalTo(32) }
            
            let verticalLineView = UIView()
            verticalLineView.backgroundColor = .gray153
            verticalLineView.snp.makeConstraints { $0.width.equalTo(1) }
            
            let titleLabel = UILabel()
            titleLabel.text = systemLabels[index]
            titleLabel.font = .font(type: .poppins400, size: 10)
            titleLabel.textColor = .gray153
            
            let descriptionLabel = UILabel()
            descriptionLabel.text = "20 min"
            descriptionLabel.font = .font(type: .poppins700, size: 12)
            
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
    }
}
