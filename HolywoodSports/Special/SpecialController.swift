import Foundation
import WebKit

class SpecialController: UIViewController, WKNavigationDelegate {
    
    var path: String
    var navigation: Bool
    
    init(path: String, navigation: Bool) {
        self.path = path
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    static func showPrivacy(_ url: String, navigation: Bool = false) {
        let from = UIApplication.shared.firstKeyWindow?.rootViewController
        let vc = SpecialController(path: url, navigation: navigation)
        vc.modalPresentationStyle = .fullScreen
        from?.present(vc, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func navigationView() -> UIView {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            stackView.heightAnchor.constraint(equalToConstant: 48)
        ])
    
        let closeButton = UIButton()
        closeButton.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        closeButton.setImage(UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = .gray
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        stackView.addArrangedSubview(UIView())
        stackView.addArrangedSubview(closeButton)
        
        return stackView
    }
    
    private func config() {
        let wkwebView = WKWebView()
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpShouldHandleCookies = true
        
        wkwebView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(wkwebView)
        
        if navigation {
            let navView = navigationView()
            NSLayoutConstraint.activate([
                wkwebView.topAnchor.constraint(equalTo: navView.safeAreaLayoutGuide.bottomAnchor),
                wkwebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                wkwebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                wkwebView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                wkwebView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                wkwebView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                wkwebView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                wkwebView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        
        wkwebView.load(request)
    }
    
    @objc private func dismissScreen() {
        dismiss(animated: true)
    }
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?.keyWindow
    }
}
