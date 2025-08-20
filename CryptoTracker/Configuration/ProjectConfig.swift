import Foundation

enum ProjectConfig {
    static let minimumIOSVersion = "17.0"
    static let appName = "CryptoTracker"
    static let appVersion = "2.0.0"
    
    enum API {
        static let baseURL = "https://api.coingecko.com/api/v3"
        static let requestTimeout: TimeInterval = 30
        static let maxRetries = 3
    }
    
    enum Cache {
        static let maxAge: TimeInterval = 300 // 5 minutes
        static let maxCacheSize = 1000
    }
    
    enum UI {
        static let animationDuration: Double = 0.3
        static let cornerRadius: CGFloat = 12
        static let spacing: CGFloat = 16
    }
}
