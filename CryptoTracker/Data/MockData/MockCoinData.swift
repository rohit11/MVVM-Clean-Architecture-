import Foundation

struct MockCoinData {
    static let enhancedBitcoin = Coin(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
        currentPrice: 45000.0,
        marketCap: 850000000000,
        priceChangePercentage7d: 5.5,
        priceChangePercentage1h: 1.2,
        priceChangePercentage24h: 3.1,
        priceChangePercentage30d: 10.5,
        priceChangePercentage200d: 25.0,
        priceChangePercentage1y: 50.0,
        
        // Enhanced Market Data
        marketCapRank: 1,
        circulatingSupply: 19500000,
        totalSupply: 21000000,
        maxSupply: 21000000,
        volume24h: 25000000000,
        marketCapDominance: 45.2,
        allTimeHigh: 69000.0,
        allTimeLow: 67.81,
        allTimeHighDate: Date().addingTimeInterval(-365 * 24 * 3600), // 1 year ago
        allTimeLowDate: Date().addingTimeInterval(-365 * 24 * 3600 * 3), // 3 years ago
        roi: ROIData(percentage: 125.5, currency: "usd", times: 2.25),
        
        // Social & Sentiment Data
        socialData: SocialData(
            twitterFollowers: 4500000,
            redditSubscribers: 4500000,
            redditActiveUsers: 125000,
            githubCommits: 25000,
            githubStars: 68000,
            githubForks: 35000,
            developerScore: 85,
            sentimentScore: 7.8,
            fearGreedIndex: 65,
            trendingRank: 1
        ),
        
        // Portfolio Data
        isInWatchlist: true,
        isInPortfolio: true,
        portfolioQuantity: 0.5,
        portfolioValue: 22500.0,
        portfolioProfitLoss: 2500.0,
        portfolioProfitLossPercentage: 12.5
    )
    
    static let mockNews = [
        NewsArticle(
            id: "1",
            title: "Bitcoin Surges Past $45,000 as Institutional Adoption Grows",
            summary: "Major financial institutions continue to show interest in Bitcoin, driving the price to new heights.",
            content: "Full article content would go here...",
            url: "https://example.com/news1",
            imageUrl: "https://example.com/image1.jpg",
            publishedAt: Date().addingTimeInterval(-3600), // 1 hour ago
            source: "CryptoNews",
            category: .market,
            sentiment: .positive,
            relatedCoins: ["bitcoin"]
        ),
        NewsArticle(
            id: "2",
            title: "New Bitcoin ETF Applications Filed with SEC",
            summary: "Several companies have submitted applications for Bitcoin ETFs, signaling growing mainstream acceptance.",
            content: "Full article content would go here...",
            url: "https://example.com/news2",
            imageUrl: "https://example.com/image2.jpg",
            publishedAt: Date().addingTimeInterval(-7200), // 2 hours ago
            source: "FinanceDaily",
            category: .regulatory,
            sentiment: .positive,
            relatedCoins: ["bitcoin"]
        ),
        NewsArticle(
            id: "3",
            title: "Bitcoin Network Upgrade Improves Transaction Efficiency",
            summary: "Latest Bitcoin protocol update reduces transaction fees and improves network performance.",
            content: "Full article content would go here...",
            url: "https://example.com/news3",
            imageUrl: "https://example.com/image3.jpg",
            publishedAt: Date().addingTimeInterval(-14400), // 4 hours ago
            source: "TechCrypto",
            category: .technical,
            sentiment: .positive,
            relatedCoins: ["bitcoin"]
        )
    ]
    
    static let mockPortfolioActions = [
        PortfolioAction(
            id: "1",
            coinId: "bitcoin",
            actionType: .buy,
            quantity: 0.5,
            price: 40000.0,
            date: Date().addingTimeInterval(-7 * 24 * 3600), // 1 week ago
            notes: "Initial investment"
        ),
        PortfolioAction(
            id: "2",
            coinId: "bitcoin",
            actionType: .addToWatchlist,
            quantity: nil,
            price: nil,
            date: Date().addingTimeInterval(-14 * 24 * 3600), // 2 weeks ago
            notes: nil
        )
    ]
    
    static let mockPriceAlerts = [
        PriceAlert(
            id: "1",
            coinId: "bitcoin",
            targetPrice: 50000.0,
            alertType: .above,
            isActive: true,
            createdAt: Date().addingTimeInterval(-3 * 24 * 3600), // 3 days ago
            triggeredAt: nil
        ),
        PriceAlert(
            id: "2",
            coinId: "bitcoin",
            targetPrice: 40000.0,
            alertType: .below,
            isActive: true,
            createdAt: Date().addingTimeInterval(-5 * 24 * 3600), // 5 days ago
            triggeredAt: nil
        )
    ]
}
