import Foundation

struct CoinDTO: Codable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double?
    let priceChangePercentage7d: Double?
    let priceChangePercentage1h: Double?
    let priceChangePercentage24h: Double?
    let priceChangePercentage30d: Double?
    let priceChangePercentage200d: Double?
    let priceChangePercentage1y: Double?
    
    // Enhanced Market Data
    let marketCapRank: Int?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let volume24h: Double?
    let marketCapDominance: Double?
    let allTimeHigh: Double?
    let allTimeLow: Double?
    let allTimeHighDate: String?
    let allTimeLowDate: String?
    let roi: ROIDataDTO?
    
    // Social & Sentiment Data
    let socialData: SocialDataDTO?
    
    // Portfolio Data (will be populated from local storage)
    let isInWatchlist: Bool?
    let isInPortfolio: Bool?
    let portfolioQuantity: Double?
    let portfolioValue: Double?
    let portfolioProfitLoss: Double?
    let portfolioProfitLossPercentage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case priceChangePercentage7d = "price_change_percentage_7d_in_currency"
        case priceChangePercentage1h = "price_change_percentage_1h_in_currency"
        case priceChangePercentage24h = "price_change_percentage_24h_in_currency"
        case priceChangePercentage30d = "price_change_percentage_30d_in_currency"
        case priceChangePercentage200d = "price_change_percentage_200d_in_currency"
        case priceChangePercentage1y = "price_change_percentage_1y_in_currency"
        
        // Enhanced Market Data
        case marketCapRank = "market_cap_rank"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case volume24h = "total_volume"
        case marketCapDominance = "market_cap_dominance"
        case allTimeHigh = "ath"
        case allTimeLow = "atl"
        case allTimeHighDate = "ath_date"
        case allTimeLowDate = "atl_date"
        case roi
        
        // Social Data
        case socialData = "community_data"
        
        // Portfolio Data (not from API)
        case isInWatchlist, isInPortfolio, portfolioQuantity, portfolioValue, portfolioProfitLoss, portfolioProfitLossPercentage
    }
    
    func toDomain() -> Coin {
        let dateFormatter = ISO8601DateFormatter()
        
        return Coin(
            id: id,
            symbol: symbol,
            name: name,
            image: image,
            currentPrice: currentPrice,
            marketCap: marketCap,
            priceChangePercentage7d: priceChangePercentage7d,
            priceChangePercentage1h: priceChangePercentage1h,
            priceChangePercentage24h: priceChangePercentage24h,
            priceChangePercentage30d: priceChangePercentage30d,
            priceChangePercentage200d: priceChangePercentage200d,
            priceChangePercentage1y: priceChangePercentage1y,
            
            // Enhanced Market Data
            marketCapRank: marketCapRank,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            volume24h: volume24h,
            marketCapDominance: marketCapDominance,
            allTimeHigh: allTimeHigh,
            allTimeLow: allTimeLow,
            allTimeHighDate: allTimeHighDate.flatMap { dateFormatter.date(from: $0) },
            allTimeLowDate: allTimeLowDate.flatMap { dateFormatter.date(from: $0) },
            roi: roi?.toDomain(),
            
            // Social & Sentiment Data
            socialData: socialData?.toDomain(),
            
            // Portfolio Data
            isInWatchlist: isInWatchlist ?? false,
            isInPortfolio: isInPortfolio ?? false,
            portfolioQuantity: portfolioQuantity,
            portfolioValue: portfolioValue,
            portfolioProfitLoss: portfolioProfitLoss,
            portfolioProfitLossPercentage: portfolioProfitLossPercentage
        )
    }
}

struct ROIDataDTO: Codable {
    let percentage: Double?
    let currency: String?
    let times: Double?
    
    func toDomain() -> ROIData {
        ROIData(
            percentage: percentage,
            currency: currency,
            times: times
        )
    }
}

struct SocialDataDTO: Codable {
    let twitterFollowers: Int?
    let redditSubscribers: Int?
    let redditActiveUsers: Int?
    let githubCommits: Int?
    let githubStars: Int?
    let githubForks: Int?
    let developerScore: Int?
    let sentimentScore: Double?
    let fearGreedIndex: Int?
    let trendingRank: Int?
    
    enum CodingKeys: String, CodingKey {
        case twitterFollowers = "twitter_followers"
        case redditSubscribers = "reddit_subscribers"
        case redditActiveUsers = "reddit_active_users"
        case githubCommits = "github_commits"
        case githubStars = "github_stars"
        case githubForks = "github_forks"
        case developerScore = "developer_score"
        case sentimentScore = "sentiment_score"
        case fearGreedIndex = "fear_greed_index"
        case trendingRank = "trending_rank"
    }
    
    func toDomain() -> SocialData {
        SocialData(
            twitterFollowers: twitterFollowers,
            redditSubscribers: redditSubscribers,
            redditActiveUsers: redditActiveUsers,
            githubCommits: githubCommits,
            githubStars: githubStars,
            githubForks: githubForks,
            developerScore: developerScore,
            sentimentScore: sentimentScore,
            fearGreedIndex: fearGreedIndex,
            trendingRank: trendingRank
        )
    }
}
