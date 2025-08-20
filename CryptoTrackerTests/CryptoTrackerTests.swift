//
//  CryptoTrackerTests.swift
//  CryptoTrackerTests
//
//  Created by Rohit Nisal on 7/24/25.
//

import Testing
import SwiftData
@testable import CryptoTracker

struct CryptoTrackerTests {
    
    @Test func testCoinDomainModel() async throws {
        let coin = Coin(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://example.com/bitcoin.png",
            currentPrice: 50000.0,
            marketCap: 1000000000000,
            priceChangePercentage7d: 5.5,
            priceChangePercentage1h: 1.2,
            priceChangePercentage24h: 3.1,
            priceChangePercentage30d: 10.5,
            priceChangePercentage200d: 25.0,
            priceChangePercentage1y: 50.0
            // All other parameters have default values in the initializer
        )
        
        #expect(coin.id == "bitcoin")
        #expect(coin.symbol == "btc")
        #expect(coin.name == "Bitcoin")
        #expect(coin.formattedPrice == "$50000.00")
        #expect(coin.formattedMarketCap == "$1000000000000")
        #expect(coin.priceChangeColor == .green)
        #expect(coin.isPositiveChange == true)
        
        // Test default values for new properties
        #expect(coin.isInWatchlist == false)
        #expect(coin.isInPortfolio == false)
        #expect(coin.marketCapRank == nil)
        #expect(coin.socialData == nil)
    }
    
    @Test func testCoinErrorLocalization() async throws {
        let networkError = CoinError.networkError("Connection failed")
        let noInternetError = CoinError.noInternetConnection
        let serverError = CoinError.serverError(500)
        
        #expect(networkError.errorDescription?.contains("Connection failed") == true)
        #expect(noInternetError.errorDescription?.contains("No internet connection") == true)
        #expect(serverError.errorDescription?.contains("Server error (Code: 500)") == true)
    }
    
    @Test func testUseCaseInitialization() async throws {
        // This would require mock dependencies in a real test
        // For now, just testing the structure
        #expect(true) // Placeholder test
    }
}
