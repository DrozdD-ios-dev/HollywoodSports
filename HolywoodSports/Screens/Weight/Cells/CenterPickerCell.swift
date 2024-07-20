//
//  CenterPickerCell.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 15.07.2024.
//

import UIKit

final class CenterPickerCell: UICollectionViewCell {
  
    // MARK: - Views

    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins600, size: 19)
        label.textAlignment = .center
        return label
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Functions

extension CenterPickerCell {
    
    func configure(text: String) {
        numberLabel.text = text
    }
}

// MARK: - Layout

extension CenterPickerCell {
    
    private func addSubviews() {
        contentView.addSubview(numberLabel)
    }
    
    private func makeConstraints() {
        
        numberLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
