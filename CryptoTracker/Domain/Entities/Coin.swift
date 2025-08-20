import Foundation
import SwiftUI

struct Coin: Identifiable, Equatable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double?
    let priceChangePercentage7d: Double?
    let priceChangePercentage1h: Double?
    let priceChangePercentage24h: Double?
    let priceChangePercentage30d: Double?
    let priceChangePercentage200d: Double?
    let priceChangePercentage1y: Double?
    
    // Enhanced Market Data
    let marketCapRank: Int?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let volume24h: Double?
    let marketCapDominance: Double?
    let allTimeHigh: Double?
    let allTimeLow: Double?
    let allTimeHighDate: Date?
    let allTimeLowDate: Date?
    let roi: ROIData?
    
    // Social & Sentiment Data
    let socialData: SocialData?
    
    // Portfolio Data
    let isInWatchlist: Bool
    let isInPortfolio: Bool
    let portfolioQuantity: Double?
    let portfolioValue: Double?
    let portfolioProfitLoss: Double?
    let portfolioProfitLossPercentage: Double?
    
    // MARK: - Initializer
    init(
        id: String,
        symbol: String,
        name: String,
        image: String,
        currentPrice: Double,
        marketCap: Double? = nil,
        priceChangePercentage7d: Double? = nil,
        priceChangePercentage1h: Double? = nil,
        priceChangePercentage24h: Double? = nil,
        priceChangePercentage30d: Double? = nil,
        priceChangePercentage200d: Double? = nil,
        priceChangePercentage1y: Double? = nil,
        marketCapRank: Int? = nil,
        circulatingSupply: Double? = nil,
        totalSupply: Double? = nil,
        maxSupply: Double? = nil,
        volume24h: Double? = nil,
        marketCapDominance: Double? = nil,
        allTimeHigh: Double? = nil,
        allTimeLow: Double? = nil,
        allTimeHighDate: Date? = nil,
        allTimeLowDate: Date? = nil,
        roi: ROIData? = nil,
        socialData: SocialData? = nil,
        isInWatchlist: Bool = false,
        isInPortfolio: Bool = false,
        portfolioQuantity: Double? = nil,
        portfolioValue: Double? = nil,
        portfolioProfitLoss: Double? = nil,
        portfolioProfitLossPercentage: Double? = nil
    ) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.priceChangePercentage7d = priceChangePercentage7d
        self.priceChangePercentage1h = priceChangePercentage1h
        self.priceChangePercentage24h = priceChangePercentage24h
        self.priceChangePercentage30d = priceChangePercentage30d
        self.priceChangePercentage200d = priceChangePercentage200d
        self.priceChangePercentage1y = priceChangePercentage1y
        self.marketCapRank = marketCapRank
        self.circulatingSupply = circulatingSupply
        self.totalSupply = totalSupply
        self.maxSupply = maxSupply
        self.volume24h = volume24h
        self.marketCapDominance = marketCapDominance
        self.allTimeHigh = allTimeHigh
        self.allTimeLow = allTimeLow
        self.allTimeHighDate = allTimeHighDate
        self.allTimeLowDate = allTimeLowDate
        self.roi = roi
        self.socialData = socialData
        self.isInWatchlist = isInWatchlist
        self.isInPortfolio = isInPortfolio
        self.portfolioQuantity = portfolioQuantity
        self.portfolioValue = portfolioValue
        self.portfolioProfitLoss = portfolioProfitLoss
        self.portfolioProfitLossPercentage = portfolioProfitLossPercentage
    }
    
    var formattedPrice: String {
        String(format: "$%.2f", currentPrice)
    }
    
    var formattedMarketCap: String {
        guard let marketCap = marketCap else { return "N/A" }
        return String(format: "$%.0f", marketCap)
    }
    
    var formattedMarketCapRank: String {
        guard let rank = marketCapRank else { return "N/A" }
        return "#\(rank)"
    }
    
    var priceChangeColor: Color {
        guard let change = priceChangePercentage7d else { return .gray }
        return change >= 0 ? .green : .red
    }
    
    var isPositiveChange: Bool {
        guard let change = priceChangePercentage7d else { return false }
        return change >= 0
    }
    
    var formattedVolume24h: String {
        guard let volume = volume24h else { return "N/A" }
        return String(format: "$%.0f", volume)
    }
    
    var formattedCirculatingSupply: String {
        guard let supply = circulatingSupply else { return "N/A" }
        return String(format: "%.0f", supply)
    }
    
    var formattedTotalSupply: String {
        guard let supply = totalSupply else { return "N/A" }
        return String(format: "%.0f", supply)
    }
    
    var formattedMaxSupply: String {
        guard let supply = maxSupply else { return "N/A" }
        return String(format: "%.0f", supply)
    }
    
    var formattedMarketCapDominance: String {
        guard let dominance = marketCapDominance else { return "N/A" }
        return String(format: "%.2f%%", dominance)
    }
    
    var formattedAllTimeHigh: String {
        guard let ath = allTimeHigh else { return "N/A" }
        return String(format: "$%.2f", ath)
    }
    
    var formattedAllTimeLow: String {
        guard let atl = allTimeLow else { return "N/A" }
        return String(format: "$%.2f", atl)
    }
    
    var formattedPortfolioValue: String {
        guard let value = portfolioValue else { return "N/A" }
        return String(format: "$%.2f", value)
    }
    
    var formattedPortfolioProfitLoss: String {
        guard let pl = portfolioProfitLoss else { return "N/A" }
        let sign = pl >= 0 ? "+" : ""
        return String(format: "%@$%.2f", sign, pl)
    }
    
    var portfolioProfitLossColor: Color {
        guard let pl = portfolioProfitLoss else { return .gray }
        return pl >= 0 ? .green : .red
    }
}

// MARK: - Supporting Data Structures

struct ROIData: Codable, Equatable {
    let percentage: Double?
    let currency: String?
    let times: Double?
    
    var formattedPercentage: String {
        guard let percentage = percentage else { return "N/A" }
        return String(format: "%.2f%%", percentage)
    }
    
    var formattedTimes: String {
        guard let times = times else { return "N/A" }
        return String(format: "%.2fx", times)
    }
}

struct SocialData: Codable, Equatable {
    let twitterFollowers: Int?
    let redditSubscribers: Int?
    let redditActiveUsers: Int?
    let githubCommits: Int?
    let githubStars: Int?
    let githubForks: Int?
    let developerScore: Int?
    let sentimentScore: Double?
    let fearGreedIndex: Int?
    let trendingRank: Int?
    
    var formattedTwitterFollowers: String {
        guard let followers = twitterFollowers else { return "N/A" }
        return formatLargeNumber(followers)
    }
    
    var formattedRedditSubscribers: String {
        guard let subscribers = redditSubscribers else { return "N/A" }
        return formatLargeNumber(subscribers)
    }
    
    var formattedGithubStars: String {
        guard let stars = githubStars else { return "N/A" }
        return formatLargeNumber(stars)
    }
    
    var formattedDeveloperScore: String {
        guard let score = developerScore else { return "N/A" }
        return "\(score)/100"
    }
    
    var formattedSentimentScore: String {
        guard let score = sentimentScore else { return "N/A" }
        return String(format: "%.1f/10", score)
    }
    
    var fearGreedColor: Color {
        guard let index = fearGreedIndex else { return .gray }
        switch index {
        case 0..<25: return .red      // Extreme Fear
        case 25..<45: return .orange  // Fear
        case 45..<55: return .yellow  // Neutral
        case 55..<75: return .green   // Greed
        default: return .purple        // Extreme Greed
        }
    }
    
    var fearGreedText: String {
        guard let index = fearGreedIndex else { return "N/A" }
        switch index {
        case 0..<25: return "Extreme Fear"
        case 25..<45: return "Fear"
        case 45..<55: return "Neutral"
        case 55..<75: return "Greed"
        default: return "Extreme Greed"
        }
    }
    
    private func formatLargeNumber(_ number: Int) -> String {
        switch number {
        case 0..<1000:
            return "\(number)"
        case 1000..<1000000:
            return String(format: "%.1fK", Double(number) / 1000.0)
        case 1000000..<1000000000:
            return String(format: "%.1fM", Double(number) / 1000000.0)
        default:
            return String(format: "%.1fB", Double(number) / 1000000000.0)
        }
    }
}
