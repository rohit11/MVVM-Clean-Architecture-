import Foundation
import SwiftData

struct CoinRepositoryImpl: CoinRepository {
    private let remoteDataSource: CoinRemoteDataSource
    private let localDataSource: CoinLocalDataSource
    
    init(remoteDataSource: CoinRemoteDataSource, localDataSource: CoinLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func fetchTopCoins() async throws -> [Coin] {
        // Try to get local data first
        if let localCoins = try? await localDataSource.fetchCoins(),
           !localCoins.isEmpty && !localDataSource.isDataStale() {
            return localCoins
        }
        
        // Fetch from remote if local data is stale or empty
        do {
            let remoteCoins = try await remoteDataSource.fetchTopCoins()
            let domainCoins = remoteCoins.map { $0.toDomain() }
            
            // Save to local storage
            try await localDataSource.saveCoins(domainCoins)
            
            return domainCoins
        } catch {
            // If remote fails, try to return local data even if stale
            if let localCoins = try? await localDataSource.fetchCoins(), !localCoins.isEmpty {
                return localCoins
            }
            throw error
        }
    }
    
    func searchCoins(query: String) async throws -> [Coin] {
        // For search, always use remote data
        let remoteCoins = try await remoteDataSource.searchCoins(query: query)
        return remoteCoins.map { $0.toDomain() }
    }
    
    func refreshCoins() async throws -> [Coin] {
        // Force refresh from remote
        let remoteCoins = try await remoteDataSource.fetchTopCoins()
        let domainCoins = remoteCoins.map { $0.toDomain() }
        
        // Update local storage
        try await localDataSource.saveCoins(domainCoins)
        
        return domainCoins
    }
    
    // MARK: - Enhanced coin details
    func getCoinDetails(coinId: String) async throws -> Coin {
        // For now, return a mock enhanced coin
        // In a real implementation, you'd fetch detailed data from the API
        return MockCoinData.enhancedBitcoin
    }
    
    // MARK: - News functionality
    func getCoinNews(coinId: String, limit: Int) async throws -> [NewsArticle] {
        // For now, return mock news data
        // In a real implementation, you'd fetch from a news API
        return MockCoinData.mockNews
    }
    
    // MARK: - Portfolio management
    func addToWatchlist(coinId: String) async throws {
        // In a real implementation, you'd save to local storage or API
        print("Added \(coinId) to watchlist")
    }
    
    func removeFromWatchlist(coinId: String) async throws {
        // In a real implementation, you'd remove from local storage or API
        print("Removed \(coinId) from watchlist")
    }
    
    func addToPortfolio(coinId: String, quantity: Double, price: Double, notes: String?) async throws {
        // In a real implementation, you'd save to local storage or API
        print("Added \(coinId) to portfolio: \(quantity) at $\(price)")
    }
    
    func removeFromPortfolio(coinId: String, quantity: Double, price: Double, notes: String?) async throws {
        // In a real implementation, you'd update local storage or API
        print("Removed \(coinId) from portfolio: \(quantity) at $\(price)")
    }
    
    func setPriceAlert(coinId: String, targetPrice: Double, alertType: PriceAlert.AlertType) async throws {
        // In a real implementation, you'd save to local storage or API
        print("Set price alert for \(coinId): \(alertType.displayName) at $\(targetPrice)")
    }
    
    func removePriceAlert(alertId: String) async throws {
        // In a real implementation, you'd remove from local storage or API
        print("Removed price alert: \(alertId)")
    }
    
    func getPortfolioActions(coinId: String) async throws -> [PortfolioAction] {
        // For now, return mock portfolio actions
        // In a real implementation, you'd fetch from local storage or API
        return MockCoinData.mockPortfolioActions
    }
    
    func getPriceAlerts(coinId: String) async throws -> [PriceAlert] {
        // For now, return mock price alerts
        // In a real implementation, you'd fetch from local storage or API
        return MockCoinData.mockPriceAlerts
    }
}
