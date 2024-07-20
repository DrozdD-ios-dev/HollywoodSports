//
//  ProgressView.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

final class ProgressView: UIView {
    
    // MARK: - Views
    
    private let horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray51
        return view
    }()
    
    private let leftLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins700, size: 12)
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins700, size: 12)
        return label
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftLabel, rightLabel])
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let backgroundProgressLine: UIView = {
        let view = UIView()
        view.backgroundColor = .progressBarBackground
        view.layer.cornerRadius = 15
        return view
    }()
    
    private var currentProgressLine: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        let gradient = CAGradientLayer()
        gradient.colors = [ UIColor.purpleDarkGradient.cgColor, UIColor.purpleLightGradient.cgColor]
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.cornerRadius = 15
        view.layer.addSublayer(gradient)
        return view
    }()
    
    private let pointsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins700, size: 10)
        label.textColor = .label
        return label
    }()
    
    // MARK: - Properties
    
    private var gradientLayer: CAGradientLayer? {
        return currentProgressLine.layer.sublayers?.first as? CAGradientLayer
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Functions

extension ProgressView {
    
    func configure(with number: Int) {
        pointsCountLabel.text = "\(number) points"
        updateProgressLineFrame(number: number)
        updatePointsCountLabel()
    }
}

// MARK: - Private Functions

private extension ProgressView {
    
    func updateProgressLineFrame(number: Int) {
        var coefficient = 500
        switch number {
        case 0...500:
            leftLabel.text = "Beginner"
            rightLabel.text = "Medium"
        case 500...1000:
            leftLabel.text = "Medium"
            rightLabel.text = "Professional"
            coefficient = 1000
        case 1000...5000:
            leftLabel.text = "Professional"
            rightLabel.text = "Legend"
            coefficient = 5000
        case 5000...50000:
            leftLabel.text = "Legend"
            rightLabel.text = "🔥🔥🔥"
            coefficient = 50000
        default:
            break
        }
        
        let normalizedNumber = min(max(number, 0), coefficient)
        let maxWeight = 361
        let result = normalizedNumber * maxWeight / coefficient
        let frame = CGRect(x: 0, y: 0, width: result, height: 30)
        currentProgressLine.frame = frame
        gradientLayer?.frame = currentProgressLine.bounds
    }
    
    func updatePointsCountLabel() {
        if currentProgressLine.frame.width <= 60 {
            pointsCountLabel.textColor = .black
        } else {
            pointsCountLabel.textColor = .white
        }
    }
}

// MARK: - Layout

private extension ProgressView {
    
    func addSubviews() {
        addSubview(horizontalStack)
        addSubview(horizontalLine)
        addSubview(backgroundProgressLine)
        backgroundProgressLine.addSubview(currentProgressLine)
        currentProgressLine.addSubview(pointsCountLabel)
    }
    
    func makeConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(83)
        }
        
        horizontalStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().inset(24)
        }
        
        horizontalLine.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        backgroundProgressLine.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(30)
        }
        
        currentProgressLine.snp.makeConstraints { make in
            make.height.leading.equalToSuperview()
        }
        
        pointsCountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
    }
}
