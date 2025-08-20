import Foundation

protocol CoinRepository {
    func fetchTopCoins() async throws -> [Coin]
    func searchCoins(query: String) async throws -> [Coin]
    func refreshCoins() async throws -> [Coin]
    
    // Enhanced coin details
    func getCoinDetails(coinId: String) async throws -> Coin
    
    // News functionality
    func getCoinNews(coinId: String, limit: Int) async throws -> [NewsArticle]
    
    // Portfolio management
    func addToWatchlist(coinId: String) async throws
    func removeFromWatchlist(coinId: String) async throws
    func addToPortfolio(coinId: String, quantity: Double, price: Double, notes: String?) async throws
    func removeFromPortfolio(coinId: String, quantity: Double, price: Double, notes: String?) async throws
    func setPriceAlert(coinId: String, targetPrice: Double, alertType: PriceAlert.AlertType) async throws
    func removePriceAlert(alertId: String) async throws
    func getPortfolioActions(coinId: String) async throws -> [PortfolioAction]
    func getPriceAlerts(coinId: String) async throws -> [PriceAlert]
}
