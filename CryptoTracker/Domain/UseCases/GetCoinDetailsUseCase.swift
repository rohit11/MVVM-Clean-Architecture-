import Foundation

struct GetCoinDetailsUseCase {
    private let repository: CoinRepository
    
    init(repository: CoinRepository) {
        self.repository = repository
    }
    
    func execute(coinId: String) async throws -> Coin {
        return try await repository.getCoinDetails(coinId: coinId)
    }
}
