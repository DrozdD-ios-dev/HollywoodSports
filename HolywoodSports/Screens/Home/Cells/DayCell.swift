import UIKit

final class DayCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private let characterLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins600, size: 14)
        return label
    }()
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins600, size: 14)
        return label
    }()
    
    private lazy var verticalStack = {
        let stack = UIStackView(arrangedSubviews: [characterLabel, numberLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let opacityView: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.alpha = 0.6
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 12
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public Functions

extension DayCell {
    
    func configure(model: Day) {
        characterLabel.text = model.character
        numberLabel.text = "\(model.dayNumber)"
        backgroundColor = UIColor(named: "\(model.color )")
        opacityView.alpha = model.opacity
    }
}

// MARK: - Layout

extension DayCell {
    
    private func addSubviews() {
        contentView.addSubview(verticalStack)
        contentView.addSubview(opacityView)
    }
    
    private func makeConstraints() {
        verticalStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        opacityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
