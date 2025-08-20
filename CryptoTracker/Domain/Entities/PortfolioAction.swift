import Foundation
import SwiftUI

struct PortfolioAction: Identifiable, Equatable {
    let id: String
    let coinId: String
    let actionType: ActionType
    let quantity: Double?
    let price: Double?
    let date: Date
    let notes: String?
    
    enum ActionType: String, CaseIterable, Codable {
        case buy = "buy"
        case sell = "sell"
        case addToWatchlist = "add_to_watchlist"
        case removeFromWatchlist = "remove_from_watchlist"
        case setAlert = "set_alert"
        case removeAlert = "remove_alert"
        
        var displayName: String {
            switch self {
            case .buy: return "Buy"
            case .sell: return "Sell"
            case .addToWatchlist: return "Add to Watchlist"
            case .removeFromWatchlist: return "Remove from Watchlist"
            case .setAlert: return "Set Alert"
            case .removeAlert: return "Remove Alert"
            }
        }
        
        var icon: String {
            switch self {
            case .buy: return "plus.circle.fill"
            case .sell: return "minus.circle.fill"
            case .addToWatchlist: return "eye.fill"
            case .removeFromWatchlist: return "eye.slash.fill"
            case .setAlert: return "bell.fill"
            case .removeAlert: return "bell.slash.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .buy: return .green
            case .sell: return .red
            case .addToWatchlist: return .blue
            case .removeFromWatchlist: return .gray
            case .setAlert: return .orange
            case .removeAlert: return .gray
            }
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    var formattedQuantity: String {
        guard let quantity = quantity else { return "N/A" }
        return String(format: "%.4f", quantity)
    }
    
    var formattedPrice: String {
        guard let price = price else { return "N/A" }
        return String(format: "$%.2f", price)
    }
    
    var formattedValue: String {
        guard let quantity = quantity, let price = price else { return "N/A" }
        let value = quantity * price
        return String(format: "$%.2f", value)
    }
}

struct PriceAlert: Identifiable, Equatable {
    let id: String
    let coinId: String
    let targetPrice: Double
    let alertType: AlertType
    let isActive: Bool
    let createdAt: Date
    let triggeredAt: Date?
    
    enum AlertType: String, CaseIterable, Codable {
        case above = "above"
        case below = "below"
        case percentageChange = "percentage_change"
        
        var displayName: String {
            switch self {
            case .above: return "Above"
            case .below: return "Below"
            case .percentageChange: return "Percentage Change"
            }
        }
        
        var icon: String {
            switch self {
            case .above: return "arrow.up.circle"
            case .below: return "arrow.down.circle"
            case .percentageChange: return "percent"
            }
        }
        
        var color: Color {
            switch self {
            case .above: return .green
            case .below: return .red
            case .percentageChange: return .orange
            }
        }
    }
    
    var formattedTargetPrice: String {
        String(format: "$%.2f", targetPrice)
    }
    
    var formattedCreatedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: createdAt)
    }
    
    var statusText: String {
        if triggeredAt != nil {
            return "Triggered \(formattedCreatedDate)"
        } else if isActive {
            return "Active"
        } else {
            return "Inactive"
        }
    }
    
    var statusColor: Color {
        if triggeredAt != nil {
            return .green
        } else if isActive {
            return .blue
        } else {
            return .gray
        }
    }
}
