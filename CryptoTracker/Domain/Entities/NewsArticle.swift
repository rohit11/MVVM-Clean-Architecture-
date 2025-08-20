import Foundation
import SwiftUI

struct NewsArticle: Identifiable, Equatable {
    let id: String
    let title: String
    let summary: String
    let content: String?
    let url: String
    let imageUrl: String?
    let publishedAt: Date
    let source: String
    let category: NewsCategory
    let sentiment: NewsSentiment
    let relatedCoins: [String] // Coin IDs
    
    enum NewsCategory: String, CaseIterable, Codable {
        case general = "general"
        case regulatory = "regulatory"
        case technical = "technical"
        case adoption = "adoption"
        case security = "security"
        case market = "market"
        
        var displayName: String {
            switch self {
            case .general: return "General"
            case .regulatory: return "Regulatory"
            case .technical: return "Technical"
            case .adoption: return "Adoption"
            case .security: return "Security"
            case .market: return "Market"
            }
        }
        
        var icon: String {
            switch self {
            case .general: return "newspaper"
            case .regulatory: return "building.2"
            case .technical: return "gearshape"
            case .adoption: return "person.3"
            case .security: return "shield"
            case .market: return "chart.line.uptrend.xyaxis"
            }
        }
        
        var color: Color {
            switch self {
            case .general: return .blue
            case .regulatory: return .purple
            case .technical: return .orange
            case .adoption: return .green
            case .security: return .red
            case .market: return .indigo
            }
        }
    }
    
    enum NewsSentiment: String, CaseIterable, Codable {
        case positive = "positive"
        case neutral = "neutral"
        case negative = "negative"
        
        var displayName: String {
            switch self {
            case .positive: return "Positive"
            case .neutral: return "Neutral"
            case .negative: return "Negative"
            }
        }
        
        var color: Color {
            switch self {
            case .positive: return .green
            case .neutral: return .gray
            case .negative: return .red
            }
        }
        
        var icon: String {
            switch self {
            case .positive: return "arrow.up.circle.fill"
            case .neutral: return "minus.circle.fill"
            case .negative: return "arrow.down.circle.fill"
            }
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: publishedAt)
    }
    
    var timeAgo: String {
        let interval = Date().timeIntervalSince(publishedAt)
        
        switch interval {
        case 0..<3600: // Less than 1 hour
            let minutes = Int(interval / 60)
            return "\(minutes)m ago"
        case 3600..<86400: // Less than 1 day
            let hours = Int(interval / 3600)
            return "\(hours)h ago"
        case 86400..<604800: // Less than 1 week
            let days = Int(interval / 86400)
            return "\(days)d ago"
        case 604800..<2592000: // Less than 1 month
            let weeks = Int(interval / 604800)
            return "\(weeks)w ago"
        default:
            let months = Int(interval / 2592000)
            return "\(months)mo ago"
        }
    }
}
