//
//  TodayTextCell.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 17.07.2024.
//

import UIKit

final class TodayTextCell: UICollectionViewCell {
    
    // MARK: - Properties

    // MARK: - Views
    
    private let todayPlanLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.font(type: .poppins700, size: 18)
        label.textAlignment = .left
        label.text = "Today Plan"
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

// MARK: - Layout

extension TodayTextCell {
    
    private func addSubviews() {
        contentView.addSubview(todayPlanLabel)
    }
    
    private func makeConstraints() {
        todayPlanLabel.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview()
        }
    }
}
