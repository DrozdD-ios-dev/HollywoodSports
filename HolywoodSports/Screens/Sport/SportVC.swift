//
//  SportVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 12.07.2024.
//

import UIKit

protocol SportOutput: AnyObject {
    func reload()
}

final class SportVC: BaseController {
    
    // MARK: - Views
    
    private let characterLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters"
        label.font = UIFont(name: "Symbol", size: 34)
        return label
    }()
    
    lazy var characterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 10, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.bounces = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
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
        view.backgroundColor = UIColor(named: Colors.background.rawValue)
        addSubviews()
        makeConstraints()
        
        Task {
            await presenter.viewDidLoad()
        }
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
    
    func reload() {
        characterCollectionView.reloadData()
    }
}

// MARK: - Layout

private extension SportVC {
    
    func addSubviews() {
        view.addSubview(characterLabel)
        view.addSubview(characterCollectionView)
    }
    
    func makeConstraints() {
        
        characterLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.leading.equalToSuperview().inset(16)
        }
        
        characterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(characterLabel.snp.bottom)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
}

// MARK: - CollectionView DataSource / Delegate

//extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return presenter.characters?.count ?? 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else { return UICollectionViewCell() }
//        cell.configure(with: presenter.characters?[indexPath.item])
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 170, height: 260)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let vc = SecondAssembly.build(character: presenter.characters?[indexPath.item])
//        navigationController?.pushViewController(vc, animated: true)
//    }
//}


