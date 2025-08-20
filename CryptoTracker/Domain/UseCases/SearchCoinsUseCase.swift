import Foundation

struct SearchCoinsUseCase {
    private let repository: CoinRepository
    
    init(repository: CoinRepository) {
        self.repository = repository
    }
    
    func execute(query: String) async throws -> [Coin] {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return []
        }
        return try await repository.searchCoins(query: query)
    }
}
