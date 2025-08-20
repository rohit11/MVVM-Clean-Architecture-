import Foundation

struct GetCoinNewsUseCase {
    private let repository: CoinRepository
    
    init(repository: CoinRepository) {
        self.repository = repository
    }
    
    func execute(coinId: String, limit: Int = 20) async throws -> [NewsArticle] {
        return try await repository.getCoinNews(coinId: coinId, limit: limit)
    }
}
