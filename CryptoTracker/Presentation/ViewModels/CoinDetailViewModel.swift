import Foundation
import SwiftUI
import UIKit

// StatisticItem is defined in SharedTypes.swift and is accessible here

@Observable
@MainActor
class CoinDetailViewModel {
    private let getCoinDetailsUseCase: GetCoinDetailsUseCase
    private let getCoinNewsUseCase: GetCoinNewsUseCase
    private let portfolioManagementUseCase: PortfolioManagementUseCase
    
    let coin: Coin
    
    // State
    var news: [NewsArticle] = []
    var isLoadingNews = false
    var newsError: String? = nil
    var selectedTab = 0
    
    // Computed Properties
    var priceChangeColor: Color {
        coin.priceChangeColor
    }
    
    var formattedPrice: String {
        coin.formattedPrice
    }
    
    var formattedMarketCap: String {
        coin.formattedMarketCap
    }
    
    var coinGeckoURL: URL? {
        URL(string: "https://www.coingecko.com/en/coins/\(coin.id)")
    }
    
    var marketStatistics: [StatisticItem] {
        var stats: [StatisticItem] = []
        
        // Market Cap Rank
        if let rank = coin.marketCapRank {
            stats.append(StatisticItem(
                title: "Market Cap Rank",
                value: "#\(rank)",
                subtitle: nil,
                icon: "chart.bar.fill",
                color: .blue,
                trend: nil
            ))
        }
        
        // Volume 24h
        stats.append(StatisticItem(
            title: "24h Volume",
            value: coin.formattedVolume24h,
            subtitle: nil,
            icon: "chart.line.uptrend.xyaxis",
            color: .green,
            trend: nil
        ))
        
        // Circulating Supply
        stats.append(StatisticItem(
            title: "Circulating Supply",
            value: coin.formattedCirculatingSupply,
            subtitle: nil,
            icon: "number.circle.fill",
            color: .orange,
            trend: nil
        ))
        
        // Total Supply
        if let totalSupply = coin.totalSupply {
            stats.append(StatisticItem(
                title: "Total Supply",
                value: String(format: "%.0f", totalSupply),
                subtitle: nil,
                icon: "infinity.circle.fill",
                color: .purple,
                trend: nil
            ))
        }
        
        // Max Supply
        if let maxSupply = coin.maxSupply {
            stats.append(StatisticItem(
                title: "Max Supply",
                value: String(format: "%.0f", maxSupply),
                subtitle: nil,
                icon: "arrow.up.circle.fill",
                color: .red,
                trend: nil
            ))
        }
        
        // Market Cap Dominance
        if coin.marketCapDominance != nil {
            stats.append(StatisticItem(
                title: "Market Dominance",
                value: coin.formattedMarketCapDominance,
                subtitle: nil,
                icon: "percent",
                color: .indigo,
                trend: nil
            ))
        }
        
        // All Time High
        if coin.allTimeHigh != nil {
            stats.append(StatisticItem(
                title: "All Time High",
                value: coin.formattedAllTimeHigh,
                subtitle: coin.allTimeHighDate?.formatted(date: .abbreviated, time: .omitted),
                icon: "arrow.up.circle.fill",
                color: .green,
                trend: .up
            ))
        }
        
        // All Time Low
        if coin.allTimeLow != nil {
            stats.append(StatisticItem(
                title: "All Time Low",
                value: coin.formattedAllTimeLow,
                subtitle: coin.allTimeLowDate?.formatted(date: .abbreviated, time: .omitted),
                icon: "arrow.down.circle.fill",
                color: .red,
                trend: .down
            ))
        }
        
        // ROI Data
        if let roi = coin.roi {
            stats.append(StatisticItem(
                title: "ROI",
                value: roi.formattedPercentage,
                subtitle: roi.formattedTimes,
                icon: "chart.pie.fill",
                color: .green,
                trend: .up
            ))
        }
        
        return stats
    }
    
    init(
        coin: Coin,
        getCoinDetailsUseCase: GetCoinDetailsUseCase,
        getCoinNewsUseCase: GetCoinNewsUseCase,
        portfolioManagementUseCase: PortfolioManagementUseCase
    ) {
        self.coin = coin
        self.getCoinDetailsUseCase = getCoinDetailsUseCase
        self.getCoinNewsUseCase = getCoinNewsUseCase
        self.portfolioManagementUseCase = portfolioManagementUseCase
    }
    
    // MARK: - Public Methods
    
    func getPriceChangeText(for percentage: Double?) -> String {
        guard let percentage = percentage else { return "N/A" }
        let sign = percentage >= 0 ? "+" : ""
        return String(format: "%@%.2f%%", sign, percentage)
    }
    
    func getPriceChangeColor(for percentage: Double?) -> Color {
        guard let percentage = percentage else { return .gray }
        return percentage >= 0 ? .green : .red
    }
    
    func loadNews() async {
        isLoadingNews = true
        newsError = nil
        
        do {
            news = try await getCoinNewsUseCase.execute(coinId: coin.id)
        } catch {
            newsError = error.localizedDescription
        }
        
        isLoadingNews = false
    }
    
    func toggleWatchlist() async {
        do {
            if coin.isInWatchlist {
                try await portfolioManagementUseCase.removeFromWatchlist(coinId: coin.id)
            } else {
                try await portfolioManagementUseCase.addToWatchlist(coinId: coin.id)
            }
            // Note: In a real app, you'd update the coin state here
        } catch {
            // Handle error
            print("Error toggling watchlist: \(error)")
        }
    }
    
    func addToPortfolio() async {
        // This would typically open a modal or sheet for user input
        // For now, we'll just show the action
        print("Add to portfolio tapped")
    }
    
    func setPriceAlert() async {
        // This would typically open a modal or sheet for user input
        // For now, we'll just show the action
        print("Set price alert tapped")
    }
    
    func shareCoin() {
        // Share coin information
        let shareText = "Check out \(coin.name) (\(coin.symbol.uppercased())) - Current price: \(coin.formattedPrice)"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityVC, animated: true)
        }
    }
    
    func onNewsTap(_ article: NewsArticle) {
        // Open news article in Safari or in-app browser
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url)
        }
    }
}
