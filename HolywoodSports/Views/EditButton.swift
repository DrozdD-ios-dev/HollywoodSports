//
//  EditButton.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 13.07.2024.
//

import UIKit

final class EditButton: UIView {
    
    // MARK: - Views
    
    private let editImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "edit")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let editLabel: UILabel = {
        let label = UILabel()
        label.text = "Edit photo"
        label.font = UIFont(name: Fonts.poppins500.rawValue, size: 16)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [editImage, editLabel])
        stack.spacing = 4
        stack.isUserInteractionEnabled = true
        return stack
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        backgroundColor = .clear
        layer.borderColor = UIColor(named: Colors.purpleDark.rawValue)?.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 18
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout

private extension EditButton {
    
    func addSubviews() {
        addSubview(horizontalStack)
    }
    
    func makeConstraints() {
        horizontalStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

