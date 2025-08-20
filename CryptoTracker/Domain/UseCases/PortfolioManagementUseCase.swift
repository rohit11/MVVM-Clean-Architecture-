import Foundation

struct PortfolioManagementUseCase {
    private let repository: CoinRepository
    
    init(repository: CoinRepository) {
        self.repository = repository
    }
    
    func addToWatchlist(coinId: String) async throws {
        try await repository.addToWatchlist(coinId: coinId)
    }
    
    func removeFromWatchlist(coinId: String) async throws {
        try await repository.removeFromWatchlist(coinId: coinId)
    }
    
    func addToPortfolio(coinId: String, quantity: Double, price: Double, notes: String?) async throws {
        try await repository.addToPortfolio(coinId: coinId, quantity: quantity, price: price, notes: notes)
    }
    
    func removeFromPortfolio(coinId: String, quantity: Double, price: Double, notes: String?) async throws {
        try await repository.removeFromPortfolio(coinId: coinId, quantity: quantity, price: price, notes: notes)
    }
    
    func setPriceAlert(coinId: String, targetPrice: Double, alertType: PriceAlert.AlertType) async throws {
        try await repository.setPriceAlert(coinId: coinId, targetPrice: targetPrice, alertType: alertType)
    }
    
    func removePriceAlert(alertId: String) async throws {
        try await repository.removePriceAlert(alertId: alertId)
    }
    
    func getPortfolioActions(coinId: String) async throws -> [PortfolioAction] {
        return try await repository.getPortfolioActions(coinId: coinId)
    }
    
    func getPriceAlerts(coinId: String) async throws -> [PriceAlert] {
        return try await repository.getPriceAlerts(coinId: coinId)
    }
}
