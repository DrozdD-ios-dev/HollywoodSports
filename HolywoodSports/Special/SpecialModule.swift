import Foundation

class SpecialModule {
    
    static let shared = SpecialModule()
    
    func loadPage(urlString: String) {
        if privacyCache() != nil {
            if shouldLoadNewPrivacyPolicy() {
                let currentPolicyVersion = UserDefaults.standard.integer(forKey: "PrivacyPolicyVersionKey")
                let version = currentPolicyVersion == 0 ? "" : "/\(currentPolicyVersion)"
                SpecialController.showPrivacy(urlString + version)
            }
        } else {
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, let html = String(data: data, encoding: .utf8) else { return }
                if let policyVersionString = html.slice(from: "Policy version:", to: "</p>") {
                    let policyVersion = policyVersionString.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: ".", with: "")
                    if let intVersion = Int(policyVersion) {
                        DispatchQueue.main.async {
                            self?.cachePrivacy(data: data, version: intVersion)
                            self?.loadPage(urlString: urlString)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    private func shouldLoadNewPrivacyPolicy() -> Bool {
        let currentPolicyVersion = UserDefaults.standard.integer(forKey: "PrivacyPolicyVersionKey")
        return currentPolicyVersion > 10
    }
    
    private func privacyCache() -> Data? {
        UserDefaults.standard.data(forKey: "PrivacyPolicyKey")
    }
    
    private func cachePrivacy(data: Data, version: Int) {
        UserDefaults.standard.set(data, forKey: "PrivacyPolicyKey")
        UserDefaults.standard.set(version, forKey: "PrivacyPolicyVersionKey")
    }
}

extension String {
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
