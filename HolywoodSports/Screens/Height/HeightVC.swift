import UIKit

protocol HeightOutput: AnyObject {
    func updateView()
    func nextVC()
    func dismiss()
}

final class HeightVC: BaseController {
    
    // MARK: - Views
    
    private lazy var nextButton: DefaultButton = {
        let button = DefaultButton(text: "Next")
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: CircularBackButton = {
        let button = CircularBackButton()
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins600, size: 28)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "What’s your \nheight?"
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
        collectionView.register(LeftPickerCell.self, forCellWithReuseIdentifier: LeftPickerCell.identifier)
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
        collectionView.register(CenterPickerCell.self, forCellWithReuseIdentifier: CenterPickerCell.identifier)
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
        collectionView.isScrollEnabled = false
        collectionView.register(RightPickerCell.self, forCellWithReuseIdentifier: RightPickerCell.identifier)
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
        view.isUserInteractionEnabled = false
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
        view.isUserInteractionEnabled = false
        return view
    }()
    
    // MARK: - Properties
    
    private var presenter: HeightInput
    
    // MARK: - Init
    
    init(presenter: HeightInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettings()
        addSubviews()
        makeConstraints()
        presenter.updateView()
    }
}

// MARK: - Private Function

private extension HeightVC {
    
    func setupSettings() {
        view.backgroundColor = .background
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
}

// MARK: - Actions

extension HeightVC {
    
    @objc func nextButtonTapped() {
        presenter.nextAction()
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Output

extension HeightVC: HeightOutput {
    
    func updateView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func nextVC() {
        let vc = EditPhotoAssembly.build(flag: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        dismiss(animated: true)
    }
}

// MARK: - Layout

private extension HeightVC {
    
    func addSubviews() {
        [questionLabel, purpleView, leftVerticalCollectionView, centerVerticalCollectionView, rightVerticalCollectionView, upGradientView, downGradientView, nextButton].forEach { view.addSubview($0) }
    }
    
    func makeConstraints() {
        questionLabel.snp.makeConstraints { make in
            let screen = UIScreen.main.bounds.height
            make.top.equalToSuperview().inset(screen > 851 ? 241 : 150)
            make.horizontalEdges.equalToSuperview()
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
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(nextButton.snp.width).multipliedBy(0.155)
        }
    }
}

// MARK: - CollectionView DataSource / Delegate

extension HeightVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case leftVerticalCollectionView:
            return presenter.leftValueKg.count
        case centerVerticalCollectionView:
            return presenter.centerValueKg.count
        case rightVerticalCollectionView:
            return presenter.heightElements.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case leftVerticalCollectionView:
            let cell = collectionView.dequeueReusableCell(withClass: LeftPickerCell.self, for: indexPath)
            cell.configure(text: "\(presenter.leftValueResult[indexPath.item])")
            return cell
            
        case centerVerticalCollectionView:
            let cell = collectionView.dequeueReusableCell(withClass: CenterPickerCell.self, for: indexPath)
            cell.configure(text: "\(presenter.centerValueResult[indexPath.item])")
            return cell
            
        case rightVerticalCollectionView:
            let cell = collectionView.dequeueReusableCell(withClass: RightPickerCell.self, for: indexPath)
            cell.configure(text: "\(presenter.heightElements[indexPath.item])")
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
            getLeftResult(collectionView: leftVerticalCollectionView, resultValue: presenter.leftValueResult)
            
        case centerVerticalCollectionView:
            getCenterResult(collectionView: centerVerticalCollectionView, resultValue: presenter.centerValueResult)
            
        case rightVerticalCollectionView:
            if let rightCellIndexPath = getCellIndexPath(collectionView: rightVerticalCollectionView) {
                if rightCellIndexPath.item == 1 {
                    presenter.heightType = .ft
                } else {
                    presenter.heightType = .cm
                }
                getLeftResult(collectionView: leftVerticalCollectionView, resultValue: presenter.leftValueResult)
                getCenterResult(collectionView: centerVerticalCollectionView, resultValue: presenter.centerValueResult)
                leftVerticalCollectionView.reloadData()
                centerVerticalCollectionView.reloadData()
            }
        default:
            break
        }
    }
    
    private func getLeftResult(collectionView: UICollectionView, resultValue: [Int]) {
        if let leftCellIndexPath = getCellIndexPath(collectionView: collectionView) {
            presenter.result.0 = resultValue[leftCellIndexPath.item]
        }
    }
    
    private func getCenterResult(collectionView: UICollectionView, resultValue: [Int]) {
        if let leftCellIndexPath = getCellIndexPath(collectionView: collectionView) {
            presenter.result.1 = resultValue[leftCellIndexPath.item]
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
