//
//  SportVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

protocol SportOutput: AnyObject {
    
}

final class SportVC: BaseController {
    
    // MARK: - Views
    
    private lazy var sportCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.sectionInset = .init(top: 30, left: 0, bottom: 16, right: 0)
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
    
    private var presenter: SportInput
    
    // MARK: - Init
    
    init(presenter: SportInput) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = false
        presenter.viewWillAppear()
        sportCollectionView.reloadData()
    }
}

// MARK: - Private Function

private extension SportVC {
    
}

// MARK: - Actions

private extension SportVC {
    
    
}

// MARK: - Output

extension SportVC: SportOutput {
    
}

// MARK: - Layout

private extension SportVC {
    
    func addSubviews() {
        view.addSubview(sportCollectionView)
    }
    
    func makeConstraints() {
        sportCollectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

// MARK: - CollectionView DataSource / Delegate

extension SportVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if presenter.user.showEvent {
            return 6
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if presenter.user.showEvent {
            switch indexPath.item {
            case 0: let cell = collectionView.dequeueReusableCell(withClass: EventCell.self, for: indexPath)
                return cell
            case 1: let cell = collectionView.dequeueReusableCell(withClass: TodayFirstCell.self, for: indexPath)
                cell.configure(model: presenter.trainingsOneDay[indexPath.item])
                return cell
            case 2...5: let cell = collectionView.dequeueReusableCell(withClass: TrainingCell.self, for: indexPath)
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
            case 1...4: let cell = collectionView.dequeueReusableCell(withClass: TrainingCell.self, for: indexPath)
                cell.configure(model: presenter.trainingsOneDay[indexPath.item])
                return cell
            default:
                return UICollectionViewCell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if presenter.user.showEvent {
            switch indexPath.item {
            case 0: return CGSize(width: sportCollectionView.frame.width - 32, height: 180)
            case 1: return CGSize(width: sportCollectionView.frame.width - 32, height: 160)
            case 2...5: return CGSize(width: sportCollectionView.frame.width - 32, height: 120)
            default: return CGSize(width: 50, height: 50)
            }
        } else {
            switch indexPath.item {
            case 0: return CGSize(width: sportCollectionView.frame.width - 32, height: 160)
            case 1...4: return CGSize(width: sportCollectionView.frame.width - 32, height: 120)
            default: return CGSize(width: 50, height: 50)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailAssembly.build(training: presenter.trainingsOneDay[indexPath.item], index: indexPath.item)
        navigationController?.pushViewController(vc, animated: true)
    }
}
