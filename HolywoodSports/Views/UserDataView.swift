//
//  UserDataView.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 13.07.2024.
//

import UIKit

final class UserDataView: UIView {
    
    // MARK: - Views
    
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.font(type: .poppins600, size: 16)
        label.textColor = .gray153
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.font(type: .poppins600, size: 16)
        return label
    }()
    
    
    // MARK: - Init
    
    init(title: String) {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        leftLabel.text = title
        backgroundColor = .gray51
        layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Functions
    
    func configure(with model: String) {
        rightLabel.text = model
    }
}

// MARK: - Layout

private extension UserDataView {
    
    func addSubviews() {
        addSubview(leftLabel)
        addSubview(rightLabel)
    }
    
    func makeConstraints() {
        
        self.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        rightLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
    }
}

