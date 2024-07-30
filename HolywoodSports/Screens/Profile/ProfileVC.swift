import UIKit

protocol ProfileOutput: AnyObject {
    func updateImage()
    func openGenderVC()
    func openWeightVC()
    func openHeightVC()
    func rateAppTapped()
    func privacyPolicyTapped()
    func termsOfUseTapped()
    func contactUsTapped()
}

final class ProfileVC: BaseController {
    
    // MARK: - Views
    
    private let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 70
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var editButton: EditButton = {
        let button = EditButton()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(editButtonTapped))
        button.addGestureRecognizer(gesture)
        return button
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var verticalDownStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let backgroundView = UIView()
    private let progressView = ProgressView()
    
    // MARK: - Properties
    
    private var presenter: ProfileInput
    
    // MARK: - Init
    
    init(presenter: ProfileInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        createUserViews()
        createSystemViews()
        addSubviews()
        makeConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(updateUserNotification), name: Notification.Name("UpdateUser"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        presenter.viewWillAppear()
        progressView.configure(with: presenter.user.points)
    }
}

// MARK: - Output

extension ProfileVC: ProfileOutput {
    
    func openGenderVC() {
        let vc = GenderAssembly.build(flag: false)
        navigationController?.present(vc, animated: true)
    }
    
    func openWeightVC() {
        let vc = WeightAssembly.build(flag: false)
        navigationController?.present(vc, animated: true)
    }
    
    func openHeightVC() {
        let vc = HeightAssembly.build(flag: false)
        navigationController?.present(vc, animated: true)
    }
    
    func updateImage() {
        userImage.image = CacheService.loadImageFromURL(url: presenter.user.image)
    }
    
    func rateAppTapped() {
        print("rateAppTapped")
    }
    
    func privacyPolicyTapped() {
        SpecialController.showPrivacy("https://www.google.com", navigation: true)
    }
    
    func termsOfUseTapped() {
        print("termsOfUseTapped")
    }
    
    func contactUsTapped() {
        print("contactUsTapped")
    }
    
}

// MARK: - Private Function

private extension ProfileVC {
    
    func createUserViews() {
        for index in 0...2 {
            let view = UserDataView(title: presenter.userRows[index])
            view.tag = index
            let gest = UITapGestureRecognizer(target: self, action: #selector(changeValue(_:)))
            view.addGestureRecognizer(gest)
            presenter.userViews.append(view)
            verticalStack.addArrangedSubview(view)
        }
    }
    
    func createSystemViews() {
        for index in 0...3 {
            let view = SystemDataView(title: presenter.systemRows[index])
            view.tag = index
            let gest = UITapGestureRecognizer(target: self, action: #selector(systemChangeValue(_:)))
            view.addGestureRecognizer(gest)
            presenter.systemViews.append(view)
            verticalDownStack.addArrangedSubview(view)
        }
    }
}

// MARK: - Actions

extension ProfileVC {
    
    @objc func changeValue(_ sender: UITapGestureRecognizer) {
        presenter.nextAction(index: sender.view?.tag ?? 0)
    }
    
    @objc func systemChangeValue(_ sender: UITapGestureRecognizer) {
        presenter.activateSystemAction(index: sender.view?.tag ?? 0)
    }
    
    @objc func editButtonTapped() {
        let vc = EditPhotoAssembly.build(flag: false)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func updateUserNotification() {
        presenter.viewWillAppear()
    }
}

// MARK: - Layout

private extension ProfileVC {
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        [userImage, editButton, verticalStack, progressView,
         verticalDownStack].forEach { backgroundView.addSubview($0) }
    }
    
    func makeConstraints() {
        let screen = UIScreen.main.bounds.height
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.centerX.equalToSuperview()
        }
        
        userImage.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
            make.size.equalTo(143)
        }
        
        editButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(screen > 851 ? 132 : 120)
            make.top.equalTo(userImage.snp.bottom).offset(16)
            make.height.equalTo(36)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(screen > 851 ? 40 : 16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(verticalStack.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        verticalDownStack.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
