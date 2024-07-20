//
//  OnboardingVC.swift
//  HolywoodSports
//
//  Created by Дрозд Денис on 14.07.2024.
//

import UIKit

final class OnboardingVC: BaseController {
    
    // MARK: - Views
    
    private lazy var onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.isUserInteractionEnabled = true
        collectionView.register(FirstCell.self, forCellWithReuseIdentifier: FirstCell.identifier)
        collectionView.register(SecondCell.self, forCellWithReuseIdentifier: SecondCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView()
        progressBar.trackTintColor = .gray51
        progressBar.tintColor = .purpleDark
        progressBar.progress = 0.5
        return progressBar
    }()
    
    private lazy var nextButton: DefaultButton = {
        let button = DefaultButton(text: "Next")
        button.addAction(UIAction { _ in self.nextButtonTapped() }, for: .touchUpInside)
        return button
    }()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        navigationController?.setNavigationBarHidden(true, animated: true)
        addSubviews()
        makeConstraints()
    }
}

// MARK: - Private Function

private extension OnboardingVC {
    
    func nextOnboardingCell(flag: Bool) {
        guard onboardingCollectionView.collectionViewLayout is UICollectionViewFlowLayout else { return }
        let visibleRect = CGRect(origin: onboardingCollectionView.contentOffset, size: onboardingCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let visibleIndexPath = onboardingCollectionView.indexPathForItem(at: visiblePoint) else { return }
        
        var targetIndex = max(visibleIndexPath.item + 1, 0)
        if !flag { targetIndex -= 2 }
        let indexPath = IndexPath(item: targetIndex, section: visibleIndexPath.section)

        if targetIndex < 2 {
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            progressBar.progress = 1
        } else {
            let vc = GenderAssembly.build(flag: true)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - Actions

extension OnboardingVC {
    
    func nextButtonTapped() {
        nextOnboardingCell(flag: true)
    }
    
    @objc func backButtonTapped() {
        nextOnboardingCell(flag: false)
    }
}

// MARK: - Layout

private extension OnboardingVC {
    
    func addSubviews() {
        view.addSubview(nextButton)
        view.addSubview(progressBar)
        view.addSubview(onboardingCollectionView)
    }
    
    func makeConstraints() {
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(nextButton.snp.width).multipliedBy(0.155)
        }
        
        progressBar.snp.makeConstraints { make in
            make.height.equalTo(5)
            make.width.equalTo(65)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-36)
        }
        
        onboardingCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(progressBar.snp.top).offset(-34)
        }
    }
    
}

// MARK: - CollectionView DataSource / Delegate

extension OnboardingVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 2 }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withClass: FirstCell.self, for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withClass: SecondCell.self, for: indexPath)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: onboardingCollectionView.frame.width, height: onboardingCollectionView.frame.height)
    }
}
