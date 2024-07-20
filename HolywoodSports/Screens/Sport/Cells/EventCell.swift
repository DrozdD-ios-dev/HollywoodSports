//
//  EventCell.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 16.07.2024.
//

import UIKit

final class EventCell: UICollectionViewCell {

    // MARK: - Views
    
    private let eventImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImageKeys.training0.rawValue)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 23
        return imageView
    }()
    
    private let startLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins700, size: 14)
        label.textAlignment = .left
        label.textColor = .purpleDark
        label.text = "Start now"
        return label
    }()
    
    private let chevronImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Icons.chevronRight
        imageView.tintColor = .purpleDark
        return imageView
    }()
    
    private lazy var horizontalStack = UIStackView(arrangedSubviews: [startLabel, chevronImage])
    
    private let startView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let eventLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins700, size: 22)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.text = "Best Event in your \ndaily Workout"
        return label
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Functions

private extension EventCell {
    
}

// MARK: - Public Functions

extension EventCell {
    
//    func configure(text: String) {
//        numberLabel.text = text
//    }
}

// MARK: - Layout

extension EventCell {
    
    private func addSubviews() {
        contentView.addSubview(eventImage)
        eventImage.addSubview(eventLabel)
        eventImage.addSubview(startView)
        startView.addSubview(horizontalStack)
    }
    
    private func makeConstraints() {
        
        eventImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        eventLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.leading.equalToSuperview().offset(22)
        }
        
        startView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(18)
            make.leading.equalToSuperview().offset(22)
            make.width.equalTo(103)
            make.height.equalTo(41)
        }
        
        horizontalStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
        
        chevronImage.snp.makeConstraints { make in
            make.width.equalTo(5)
            make.height.equalTo(10)
        }
    }
}
