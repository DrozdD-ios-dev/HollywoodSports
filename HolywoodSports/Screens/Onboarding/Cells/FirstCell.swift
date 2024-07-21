//
//  FirstCell.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

final class FirstCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .Images.onboardingFirst
        return imageView
    }()
    
    private let gradientView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 393, height: 300)
        
        let gradient = CAGradientLayer()
        gradient.colors = [ UIColor.clear.cgColor, UIColor.background.cgColor]
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0, y: 0.6)
        view.layer.addSublayer(gradient)
        return view
    }()
    
    private let purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = .purpleDark
        return view
    }()
    
    private let upLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins800, size: 24)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Wherever You Are \nHealth Is Number One"
        return label
    }()
    
    private let downLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins400, size: 15)
        label.textColor = .gray153
        label.textAlignment = .center
        label.text = "There is no instant way to a healthy life"
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .background
        addSubviews()
        makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout

extension FirstCell {
    
    private func addSubviews() {
        [backgroundImage, gradientView, purpleView, downLabel, upLabel].forEach { contentView.addSubview($0) }
    }
    
    private func makeConstraints() {
        
        backgroundImage.snp.makeConstraints { make in
            make.height.equalTo(backgroundImage.snp.width).multipliedBy(1.5)
            make.top.horizontalEdges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(300)
        }
        
        downLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        purpleView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(14)
            make.bottom.equalTo(downLabel.snp.top).offset(-10)
            make.leading.equalTo(upLabel.snp.leading).offset(20)
        }
        
        upLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(40)
            make.bottom.equalTo(downLabel.snp.top).offset(-10)
        }
    }
}
