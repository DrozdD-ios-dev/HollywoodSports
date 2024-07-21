//swiftlint: disable cyclomatic_complexity

import UIKit

protocol HomeOutput: AnyObject {
    func updateImage()
}

final class HomeVC: BaseController {
    
    // MARK: - Views
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome in🔥"
        label.font = .font(type: .poppins600, size: 14)
        return label
    }()
    
    private let hollywoodLabel: UILabel = {
        let label = UILabel()
        let text = "HollywoodSports"
        label.font = .font(type: .poppins800, size: 24)
        
        let attributedString = NSMutableAttributedString(string: text)
        let whiteAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        let yellowAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.yellowMiddle
        ]
        attributedString.addAttributes(whiteAttributes, range: NSRange(location: 0, length: min(9, text.count)))
        attributedString.addAttributes(yellowAttributes, range: NSRange(location: 9, length: text.count - 9))
        label.attributedText = attributedString
        return label
    }()
    
    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [welcomeLabel, hollywoodLabel])
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var horizontalStack = UIStackView(arrangedSubviews: [verticalStack, userImage])
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins700, size: 18)
        return label
    }()
    
    private lazy var weekCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var sportCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(EventCell.self, forCellWithReuseIdentifier: EventCell.identifier)
        collectionView.register(TodayFirstCell.self, forCellWithReuseIdentifier: TodayFirstCell.identifier)
        collectionView.register(TrainingCell.self, forCellWithReuseIdentifier: TrainingCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var presenter: HomeInput
    
    // MARK: - Init
    
    init(presenter: HomeInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        addSubviews()
        makeConstraints()
        presenter.viewDidLoad()
        setupSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = false
        presenter.viewWillAppear()
        sportCollectionView.reloadData()
        weekCollectionView.reloadData()
    }
}

// MARK: - Output

extension HomeVC: HomeOutput {
    
    func updateImage() {
        userImage.image = CacheService.loadImageFromURL(url: presenter.user.image)
    }
}

// MARK: - Private Function

private extension HomeVC {
    
    func setupSettings() {
        dateLabel.text = DateService.currentMonthYear()
    }
}

// MARK: - Layout

private extension HomeVC {
    
    func addSubviews() {
        view.addSubview(horizontalStack)
        view.addSubview(dateLabel)
        view.addSubview(weekCollectionView)
        view.addSubview(sportCollectionView)
    }
    
    func makeConstraints() {
        let screen = UIScreen.main.bounds.height
        horizontalStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        userImage.snp.makeConstraints { make in
            make.size.equalTo(48)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(horizontalStack.snp.bottom).offset(screen > 851 ? 28 : 16)
        }
        
        weekCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.height.equalTo(55)
        }
        
        sportCollectionView.snp.makeConstraints { make in
            make.top.equalTo(weekCollectionView.snp.bottom).offset(screen > 851 ? 28 : 16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

// MARK: - CollectionView DataSource / Delegate

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case weekCollectionView:
            return 7
            
        case sportCollectionView:
            if presenter.user.showEvent {
                return 4
            } else {
                return 3
            }
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case weekCollectionView:
            let cell = collectionView.dequeueReusableCell(withClass: DayCell.self, for: indexPath)
            cell.configure(model: presenter.weekDays[indexPath.item])
            return cell
            
        case sportCollectionView:
            if presenter.user.showEvent {
                switch indexPath.item {
                case 0: let cell = collectionView.dequeueReusableCell(withClass: EventCell.self, for: indexPath)
                    return cell
                case 1: let cell = collectionView.dequeueReusableCell(withClass: TodayFirstCell.self, for: indexPath)
                    cell.configure(model: presenter.trainingsOneDay[indexPath.item])
                    return cell
                case 2...3: let cell = collectionView.dequeueReusableCell(withClass: TrainingCell.self, for: indexPath)
                    cell.configure(model: presenter.trainingsOneDay[indexPath.item])
                    return cell
                default:
                    return UICollectionViewCell()
                }
            } else {
                switch indexPath.item {
                case 0: let cell = collectionView.dequeueReusableCell(withClass: TodayFirstCell.self, for: indexPath)
                    cell.configure(model: presenter.trainingsOneDay[indexPath.item])
                    return cell
                case 1...2: let cell = collectionView.dequeueReusableCell(withClass: TrainingCell.self, for: indexPath)
                    cell.configure(model: presenter.trainingsOneDay[indexPath.item])
                    return cell
                default:
                    return UICollectionViewCell()
                }
            }
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            
        case weekCollectionView:
            return CGSize(width: 47, height: 54)
            
        case sportCollectionView:
            if presenter.user.showEvent {
                switch indexPath.item {
                case 0: return CGSize(width: sportCollectionView.frame.width - 32, height: 180)
                case 1: return CGSize(width: sportCollectionView.frame.width - 32, height: 160)
                case 2...3: return CGSize(width: sportCollectionView.frame.width - 32, height: 120)
                default: return CGSize(width: 50, height: 50)
                }
            } else {
                switch indexPath.item {
                case 0: return CGSize(width: sportCollectionView.frame.width - 32, height: 160)
                case 1...2: return CGSize(width: sportCollectionView.frame.width - 32, height: 120)
                default: return CGSize(width: 50, height: 50)
                }
            }
            
        default:
            return CGSize(width: 50, height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == sportCollectionView {
            let vc = DetailAssembly.build(training: presenter.trainingsOneDay[indexPath.item], index: indexPath.item)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
