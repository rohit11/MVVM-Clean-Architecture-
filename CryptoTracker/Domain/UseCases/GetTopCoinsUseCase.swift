import Foundation

struct GetTopCoinsUseCase {
    private let repository: CoinRepository
    
    init(repository: CoinRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Coin] {
        return try await repository.fetchTopCoins()
    }
    
    func refresh() async throws -> [Coin] {
        return try await repository.refreshCoins()
    }
}
