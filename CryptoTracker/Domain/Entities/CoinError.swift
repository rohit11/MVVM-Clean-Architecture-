import Foundation

enum CoinError: LocalizedError, Equatable {
    case networkError(String)
    case decodingError(String)
    case invalidData(String)
    case noInternetConnection
    case serverError(Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .networkError(let message):
            return "Network error: \(message)"
        case .decodingError(let message):
            return "Data error: \(message)"
        case .invalidData(let message):
            return "Invalid data: \(message)"
        case .noInternetConnection:
            return "No internet connection. Please check your network and try again."
        case .serverError(let code):
            return "Server error (Code: \(code)). Please try again later."
        case .unknown:
            return "An unexpected error occurred. Please try again."
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .noInternetConnection:
            return "Check your internet connection and try again."
        case .serverError:
            return "The server is experiencing issues. Please try again in a few minutes."
        default:
            return "Please try again. If the problem persists, contact support."
        }
    }
}
