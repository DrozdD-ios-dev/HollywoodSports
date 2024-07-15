//
//  WeightCell.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

final class WeightCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static var identifier: String {
        String(describing: self)
    }
    var user = UserService.loadUser(key: "user") ?? User.mock
    var action: (() -> Void)?
    let leftValueKg = Array(30...120)
    var leftValueResult: [Int] {
        return weightIndex == .kg ? leftValueKg : leftValueKg.map { Int((Double($0) * 2.205 * 10).rounded() / 10) }
    }
    
    var centerValueKg = Array(0...9)
    var centerValueResult: [Int] {
        return weightIndex == .kg ? centerValueKg : centerValueKg.map { Int((Double($0) * 2.205 * 10).rounded() / 10) }
    }
    
    let weightElements = ["kg", "lbs", ""]
    
    var weightIndex = Weight.kg
    var result: (Int, Int) = (50, 0) {
        didSet {
            #warning("Изменить! Лагает коллекция")
//            saveValue()
        }
    }
    
    // MARK: - Views
    
    private lazy var backButton: CircularBackButton = {
        let button = CircularBackButton()
        button.addAction(UIAction { _ in self.backButtonTapped() }, for: .touchUpInside)
        return button
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.font(type: .poppins600, size: 28)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "What’s your \ncurrent weight?"
        return label
    }()
    
    private let purpleView: UIView = {
        let view = UIView()
        view.backgroundColor = .purpleDark
        view.layer.cornerRadius = 25
        return view
    }()
    
    private lazy var leftVerticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.sectionInset = .init(top: 110, left: 0, bottom: 110, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(LeftWeightCell.self, forCellWithReuseIdentifier: LeftWeightCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var centerVerticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 40, height: 40)
        layout.sectionInset = .init(top: 110, left: 0, bottom: 110, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(CenterWeightCell.self, forCellWithReuseIdentifier: CenterWeightCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var rightVerticalCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.sectionInset = .init(top: 60, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(RightWeightCell.self, forCellWithReuseIdentifier: RightWeightCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let upGradientView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 393, height: 105)
        let gradient = CAGradientLayer()
        gradient.colors = [ UIColor.background.cgColor, UIColor.background.withAlphaComponent(0).cgColor]
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.addSublayer(gradient)
        return view
    }()
    
    private let downGradientView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 393, height: 105)
        
        let gradient = CAGradientLayer()
        gradient.colors = [ UIColor.background.withAlphaComponent(0).cgColor, UIColor.background.cgColor]
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 0.9)
        view.layer.addSublayer(gradient)
        return view
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

// MARK: - Private function

private extension WeightCell {
    
    func saveValue() {
        user.weight = Double(result.0) + (Double(result.1) / 10)
        user.weightValue = weightIndex
        UserService.saveUser(user: user, key: "user")
    }
}

// MARK: - Public Functions

extension WeightCell {
    
    func configure(action: @escaping () -> Void) {
        self.action = action
    }
}

// MARK: - Actions

private extension WeightCell {
    
    @objc func backButtonTapped() {
        action?()
        print("back")
    }
}

// MARK: - Layout

extension WeightCell {
    
    private func addSubviews() {
        [questionLabel, backButton, purpleView, leftVerticalCollectionView, centerVerticalCollectionView, rightVerticalCollectionView, upGradientView, downGradientView].forEach { contentView.addSubview($0) }
    }
    
    private func makeConstraints() {
        
        questionLabel.snp.makeConstraints { make in
            let screen = UIScreen.main.bounds.height
            make.top.equalToSuperview().inset(screen > 851 ? 241 : 150)
            make.horizontalEdges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(50)
            make.size.equalTo(48)
        }
        
        purpleView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(questionLabel.snp.bottom).offset(120)
            make.height.equalTo(56)
        }
        
        leftVerticalCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(60)
            make.centerY.equalTo(purpleView.snp.centerY)
            make.height.equalTo(260)
            make.width.equalTo(60)
        }
        
        centerVerticalCollectionView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(purpleView.snp.centerY)
            make.height.equalTo(260)
            make.width.equalTo(60)
        }
        
        rightVerticalCollectionView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(60)
            make.centerY.equalTo(purpleView.snp.centerY)
            make.height.equalTo(160)
            make.width.equalTo(60)
        }
        
        upGradientView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(purpleView.snp.top)
            make.height.equalTo(105)
        }
        
        downGradientView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(purpleView.snp.bottom).offset(15)
            make.height.equalTo(105)
        }
    }
}

// MARK: - CollectionView DataSource / Delegate

extension WeightCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case leftVerticalCollectionView:
            return leftValueKg.count
        case centerVerticalCollectionView:
            return centerValueKg.count
        case rightVerticalCollectionView:
            return weightElements.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case leftVerticalCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LeftWeightCell.identifier, for: indexPath) as? LeftWeightCell else { return UICollectionViewCell() }
            cell.configure(text: "\(leftValueResult[indexPath.item])")
            return cell
            
        case centerVerticalCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CenterWeightCell.identifier, for: indexPath) as? CenterWeightCell else { return UICollectionViewCell() }
            cell.configure(text: "\(centerValueResult[indexPath.item])")
            return cell
            
        case rightVerticalCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RightWeightCell.identifier, for: indexPath) as? RightWeightCell else { return UICollectionViewCell() }
            cell.configure(text: "\(weightElements[indexPath.item])")
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        switch scrollView {
        case leftVerticalCollectionView:
            if let leftCellIndexPath = getCellIndexPath(collectionView: leftVerticalCollectionView) {
                result.0 = leftValueResult[leftCellIndexPath.item]
            }
            
        case centerVerticalCollectionView:
            if let centerCellIndexPath = getCellIndexPath(collectionView: centerVerticalCollectionView) {
                result.1 = centerValueResult[centerCellIndexPath.item]
            }
            
        case rightVerticalCollectionView:
            if let rightCellIndexPath = getCellIndexPath(collectionView: rightVerticalCollectionView) {
                if rightCellIndexPath.item == 1 {
                    weightIndex = .lbs
                } else {
                    weightIndex = .kg
                }
                leftVerticalCollectionView.reloadData()
                centerVerticalCollectionView.reloadData()
            }
        default:
            break
        }
    }
    
    private func getCellIndexPath(collectionView: UICollectionView) -> IndexPath? {
        let centerPoint = CGPoint(x: collectionView.bounds.midX, y: collectionView.bounds.midY)
        return collectionView.indexPathForItem(at: centerPoint)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            guard let layout = leftVerticalCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            
            let cellWidthIncludingSpacing = layout.itemSize.height + layout.minimumLineSpacing
            let estimatedIndex = scrollView.contentOffset.y / cellWidthIncludingSpacing
            var index: CGFloat
            if velocity.y > 0 {
                index = ceil(estimatedIndex)
            } else if velocity.y < 0 {
                index = floor(estimatedIndex)
            } else {
                index = round(estimatedIndex)
            }
            
            targetContentOffset.pointee = CGPoint(
                x: targetContentOffset.pointee.x,
                y: index * cellWidthIncludingSpacing - scrollView.contentInset.top)
    }
}
