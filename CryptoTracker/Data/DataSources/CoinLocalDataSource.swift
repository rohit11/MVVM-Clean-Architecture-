import Foundation
import SwiftData

protocol CoinLocalDataSource {
    func saveCoins(_ coins: [Coin]) async throws
    func fetchCoins() async throws -> [Coin]
    func clearCoins() async throws
    func isDataStale() -> Bool
}

struct CoinLocalDataSourceImpl: CoinLocalDataSource {
    private let modelContext: ModelContext
    private let maxAge: TimeInterval = 300 // 5 minutes
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func saveCoins(_ coins: [Coin]) async throws {
        // Clear existing data
        try await clearCoins()
        
        // Save new data
        for coin in coins {
            let entity = CoinEntity.fromDomain(coin)
            modelContext.insert(entity)
        }
        
        try modelContext.save()
    }
    
    func fetchCoins() async throws -> [Coin] {
        let descriptor = FetchDescriptor<CoinEntity>(
            sortBy: [SortDescriptor(\.marketCap, order: .reverse)]
        )
        
        let entities = try modelContext.fetch(descriptor)
        return entities.map { $0.toDomain() }
    }
    
    func clearCoins() async throws {
        let descriptor = FetchDescriptor<CoinEntity>()
        let entities = try modelContext.fetch(descriptor)
        
        for entity in entities {
            modelContext.delete(entity)
        }
        
        try modelContext.save()
    }
    
    func isDataStale() -> Bool {
        let descriptor = FetchDescriptor<CoinEntity>(
            sortBy: [SortDescriptor(\.lastUpdated, order: .reverse)]
        )
        
        guard let latestEntity = try? modelContext.fetch(descriptor).first else {
            return true
        }
        
        let age = Date().timeIntervalSince(latestEntity.lastUpdated)
        return age > maxAge
    }
}
