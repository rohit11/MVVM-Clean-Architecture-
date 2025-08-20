import Foundation
import SwiftData

class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Data Sources
    lazy var coinRemoteDataSource: CoinRemoteDataSource = {
        CoinRemoteDataSourceImpl()
    }()
    
    func coinLocalDataSource(modelContext: ModelContext) -> CoinLocalDataSource {
        CoinLocalDataSourceImpl(modelContext: modelContext)
    }
    
    // MARK: - Repositories
    func coinRepository(modelContext: ModelContext) -> CoinRepository {
        CoinRepositoryImpl(
            remoteDataSource: coinRemoteDataSource,
            localDataSource: coinLocalDataSource(modelContext: modelContext)
        )
    }
    
    // MARK: - Use Cases
    func getTopCoinsUseCase(modelContext: ModelContext) -> GetTopCoinsUseCase {
        GetTopCoinsUseCase(repository: coinRepository(modelContext: modelContext))
    }
    
    func searchCoinsUseCase(modelContext: ModelContext) -> SearchCoinsUseCase {
        SearchCoinsUseCase(repository: coinRepository(modelContext: modelContext))
    }
    
    func getCoinDetailsUseCase(modelContext: ModelContext) -> GetCoinDetailsUseCase {
        GetCoinDetailsUseCase(repository: coinRepository(modelContext: modelContext))
    }
    
    func getCoinNewsUseCase(modelContext: ModelContext) -> GetCoinNewsUseCase {
        GetCoinNewsUseCase(repository: coinRepository(modelContext: modelContext))
    }
    
    func portfolioManagementUseCase(modelContext: ModelContext) -> PortfolioManagementUseCase {
        PortfolioManagementUseCase(repository: coinRepository(modelContext: modelContext))
    }
    
    // MARK: - ViewModels
    func coinListViewModel(modelContext: ModelContext) async -> CoinListViewModel {
        await MainActor.run {
            CoinListViewModel(
                getTopCoinsUseCase: getTopCoinsUseCase(modelContext: modelContext),
                searchCoinsUseCase: searchCoinsUseCase(modelContext: modelContext)
            )
        }
    }
    
    func coinDetailViewModel(coin: Coin) async -> CoinDetailViewModel {
        await MainActor.run {
            // For now, we'll create a mock context for the detail view
            // In a real app, you might want to pass the actual context
            let mockContext = try! ModelContainer(for: CoinEntity.self).mainContext
            
            let detailsUseCase = getCoinDetailsUseCase(modelContext: mockContext)
            let newsUseCase = getCoinNewsUseCase(modelContext: mockContext)
            let portfolioUseCase = portfolioManagementUseCase(modelContext: mockContext)
            
            return CoinDetailViewModel(
                coin: coin,
                getCoinDetailsUseCase: detailsUseCase,
                getCoinNewsUseCase: newsUseCase,
                portfolioManagementUseCase: portfolioUseCase
            )
        }
    }
}
