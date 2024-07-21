import UIKit

final class TodayFirstCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private let backgroundGrayView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray51
        view.layer.cornerRadius = 23
        return view
    }()
    
    private let trainingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        return imageView
    }()
    
    private let nameTrainingLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins500, size: 16)
        label.textAlignment = .left
        label.text = "Name Training"
        return label
    }()
    
    private let descriptionTrainingLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins400, size: 13)
        label.textAlignment = .left
        label.textColor = .gray153
        label.text = "Desc Training"
        return label
    }()
    
    private let backgroundProgressLine: UIView = {
        let view = UIView()
        view.backgroundColor = .background
        view.layer.cornerRadius = 3
        return view
    }()
    
    private var currentProgressLine: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = .purpleDark
        view.layer.cornerRadius = 3
        return view
    }()
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins700, size: 8)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTrainingLabel, descriptionTrainingLabel, backgroundProgressLine])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 10
        return stack
    }()
    
    private let todayPlanLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins700, size: 18)
        label.textAlignment = .left
        label.text = "Today Plan"
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

// MARK: - Private Functions

private extension TodayFirstCell {
    
    private func updateProgressLineFrame(number: Int) {
        let normalizedNumber = min(max(number, 0), 100)
        let maxWeight = 215
        let result = normalizedNumber * maxWeight / 100
        
        let frame = CGRect(x: 0, y: 0, width: result, height: 16)
        currentProgressLine.frame = frame
    }
}

// MARK: - Public Functions

extension TodayFirstCell {
    
    func configure(model: Training) {
        trainingImage.image = UIImage(named: model.imageName)
        nameTrainingLabel.text = model.title
        descriptionTrainingLabel.text = model.miniDescription
        percentLabel.text = "\(model.progress)%"
        updateProgressLineFrame(number: model.progress)
    }
}

// MARK: - Layout

extension TodayFirstCell {
    
    private func addSubviews() {
        contentView.addSubview(todayPlanLabel)
        contentView.addSubview(backgroundGrayView)
        backgroundGrayView.addSubview(trainingImage)
        backgroundGrayView.addSubview(verticalStack)
        backgroundProgressLine.addSubview(currentProgressLine)
        backgroundProgressLine.addSubview(percentLabel)
    }
    
    private func makeConstraints() {
        
        backgroundGrayView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(120)
        }
        
        todayPlanLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
        }

        trainingImage.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.leading.equalToSuperview().offset(11)
            make.width.equalTo(102)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.leading.equalTo(trainingImage.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        backgroundProgressLine.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(16)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
        }
    }
}
