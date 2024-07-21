import UIKit

protocol GenderOutput: AnyObject {
    func selectGenderView(index: Int)
    func dismiss()
    func nextVC()
}

final class GenderVC: BaseController {
    
    // MARK: - Views
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.font = .font(type: .poppins600, size: 28)
        label.textAlignment = .center
        label.text = "What’s your gender?"
        return label
    }()
    
    // MARK: - Properties
    
    private var presenter: GenderInput
    private var buttons = [UIButton]()
    
    // MARK: - Init
    
    init(presenter: GenderInput) {
        self.presenter = presenter
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
        setupButtons()
        addSubviews()
        makeConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Output

extension GenderVC: GenderOutput {
    
    func nextVC() {
        let vc = WeightAssembly.build(flag: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func dismiss() {
        dismiss(animated: true)
    }
    
    func selectGenderView(index: Int) {
        buttons.forEach {
            $0.backgroundColor = .gray51
            $0.tintColor = .gray153
        }
        buttons[index].backgroundColor = .purpleDark
        buttons[index].tintColor = .white
    }
}

// MARK: - Private Function

private extension GenderVC {
    
    func setupButtons() {
        for (index, value) in Gender.allCases.enumerated() {
            let button = UIButton(type: .system)
            button.tintColor = .gray153
            button.backgroundColor = .gray51
            let attributes: [NSAttributedString.Key: Any] = [ .font: UIFont.font(type: .poppins700, size: 16) ]
            let attributedString = NSAttributedString(string: value.rawValue, attributes: attributes)
            button.setAttributedTitle(attributedString, for: .normal)
            button.layer.cornerRadius = 25
            button.tag = index
            button.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
            buttons.append(button)
        }
    }
}

// MARK: - Actions

extension GenderVC {
    
    @objc func genderButtonTapped(_ sender: UIButton) {
        presenter.selectGenderView(index: sender.tag)
    }
}

// MARK: - Layout

private extension GenderVC {
    
    func addSubviews() {
        view.addSubview(questionLabel)
        buttons.forEach { view.addSubview($0) }
    }
    
    func makeConstraints() {
        questionLabel.snp.makeConstraints { make in
            let screen = UIScreen.main.bounds.height
            make.top.equalToSuperview().inset(screen > 851 ? 241 : 150)
            make.horizontalEdges.equalToSuperview()
        }
        
        buttons[0].snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(questionLabel.snp.bottom).offset(24)
            make.height.equalTo(99)
        }
        
        buttons[1].snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.top.equalTo(buttons[0].snp.bottom).offset(16)
            make.height.equalTo(99)
        }
    }
    
}
