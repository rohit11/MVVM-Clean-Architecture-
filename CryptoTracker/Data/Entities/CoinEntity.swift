import Foundation
import SwiftData

@Model
final class CoinEntity {
    @Attribute(.unique) var id: String
    var symbol: String
    var name: String
    var image: String
    var currentPrice: Double
    var marketCap: Double?
    var priceChangePercentage7d: Double?
    var priceChangePercentage1h: Double?
    var priceChangePercentage24h: Double?
    var priceChangePercentage30d: Double?
    var priceChangePercentage200d: Double?
    var priceChangePercentage1y: Double?
    
    // Enhanced Market Data
    var marketCapRank: Int?
    var circulatingSupply: Double?
    var totalSupply: Double?
    var maxSupply: Double?
    var volume24h: Double?
    var marketCapDominance: Double?
    var allTimeHigh: Double?
    var allTimeLow: Double?
    var allTimeHighDate: Date?
    var allTimeLowDate: Date?
    var roiPercentage: Double?
    var roiCurrency: String?
    var roiTimes: Double?
    
    // Social & Sentiment Data
    var twitterFollowers: Int?
    var redditSubscribers: Int?
    var redditActiveUsers: Int?
    var githubCommits: Int?
    var githubStars: Int?
    var githubForks: Int?
    var developerScore: Int?
    var sentimentScore: Double?
    var fearGreedIndex: Int?
    var trendingRank: Int?
    
    // Portfolio Data
    var isInWatchlist: Bool
    var isInPortfolio: Bool
    var portfolioQuantity: Double?
    var portfolioValue: Double?
    var portfolioProfitLoss: Double?
    var portfolioProfitLossPercentage: Double?
    
    var lastUpdated: Date
    
    init(
        id: String,
        symbol: String,
        name: String,
        image: String,
        currentPrice: Double,
        marketCap: Double? = nil,
        priceChangePercentage7d: Double? = nil,
        priceChangePercentage1h: Double? = nil,
        priceChangePercentage24h: Double? = nil,
        priceChangePercentage30d: Double? = nil,
        priceChangePercentage200d: Double? = nil,
        priceChangePercentage1y: Double? = nil,
        marketCapRank: Int? = nil,
        circulatingSupply: Double? = nil,
        totalSupply: Double? = nil,
        maxSupply: Double? = nil,
        volume24h: Double? = nil,
        marketCapDominance: Double? = nil,
        allTimeHigh: Double? = nil,
        allTimeLow: Double? = nil,
        allTimeHighDate: Date? = nil,
        allTimeLowDate: Date? = nil,
        roiPercentage: Double? = nil,
        roiCurrency: String? = nil,
        roiTimes: Double? = nil,
        twitterFollowers: Int? = nil,
        redditSubscribers: Int? = nil,
        redditActiveUsers: Int? = nil,
        githubCommits: Int? = nil,
        githubStars: Int? = nil,
        githubForks: Int? = nil,
        developerScore: Int? = nil,
        sentimentScore: Double? = nil,
        fearGreedIndex: Int? = nil,
        trendingRank: Int? = nil,
        isInWatchlist: Bool = false,
        isInPortfolio: Bool = false,
        portfolioQuantity: Double? = nil,
        portfolioValue: Double? = nil,
        portfolioProfitLoss: Double? = nil,
        portfolioProfitLossPercentage: Double? = nil
    ) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.image = image
        self.currentPrice = currentPrice
        self.marketCap = marketCap
        self.priceChangePercentage7d = priceChangePercentage7d
        self.priceChangePercentage1h = priceChangePercentage1h
        self.priceChangePercentage24h = priceChangePercentage24h
        self.priceChangePercentage30d = priceChangePercentage30d
        self.priceChangePercentage200d = priceChangePercentage200d
        self.priceChangePercentage1y = priceChangePercentage1y
        self.marketCapRank = marketCapRank
        self.circulatingSupply = circulatingSupply
        self.totalSupply = totalSupply
        self.maxSupply = maxSupply
        self.volume24h = volume24h
        self.marketCapDominance = marketCapDominance
        self.allTimeHigh = allTimeHigh
        self.allTimeLow = allTimeLow
        self.allTimeHighDate = allTimeHighDate
        self.allTimeLowDate = allTimeLowDate
        self.roiPercentage = roiPercentage
        self.roiCurrency = roiCurrency
        self.roiTimes = roiTimes
        self.twitterFollowers = twitterFollowers
        self.redditSubscribers = redditSubscribers
        self.redditActiveUsers = redditActiveUsers
        self.githubCommits = githubCommits
        self.githubStars = githubStars
        self.githubForks = githubForks
        self.developerScore = developerScore
        self.sentimentScore = sentimentScore
        self.fearGreedIndex = fearGreedIndex
        self.trendingRank = trendingRank
        self.isInWatchlist = isInWatchlist
        self.isInPortfolio = isInPortfolio
        self.portfolioQuantity = portfolioQuantity
        self.portfolioValue = portfolioValue
        self.portfolioProfitLoss = portfolioProfitLoss
        self.portfolioProfitLossPercentage = portfolioProfitLossPercentage
        self.lastUpdated = Date()
    }
    
    func toDomain() -> Coin {
        // Create ROIData if we have ROI information
        let roi: ROIData? = {
            if roiPercentage != nil || roiCurrency != nil || roiTimes != nil {
                return ROIData(
                    percentage: roiPercentage,
                    currency: roiCurrency,
                    times: roiTimes
                )
            }
            return nil
        }()
        
        // Create SocialData if we have social information
        let socialData: SocialData? = {
            if twitterFollowers != nil || redditSubscribers != nil || githubStars != nil {
                return SocialData(
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
            return nil
        }()
        
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
            marketCapRank: marketCapRank,
            circulatingSupply: circulatingSupply,
            totalSupply: totalSupply,
            maxSupply: maxSupply,
            volume24h: volume24h,
            marketCapDominance: marketCapDominance,
            allTimeHigh: allTimeHigh,
            allTimeLow: allTimeLow,
            allTimeHighDate: allTimeHighDate,
            allTimeLowDate: allTimeLowDate,
            roi: roi,
            socialData: socialData,
            isInWatchlist: isInWatchlist,
            isInPortfolio: isInPortfolio,
            portfolioQuantity: portfolioQuantity,
            portfolioValue: portfolioValue,
            portfolioProfitLoss: portfolioProfitLoss,
            portfolioProfitLossPercentage: portfolioProfitLossPercentage
        )
    }
    
    static func fromDomain(_ coin: Coin) -> CoinEntity {
        CoinEntity(
            id: coin.id,
            symbol: coin.symbol,
            name: coin.name,
            image: coin.image,
            currentPrice: coin.currentPrice,
            marketCap: coin.marketCap,
            priceChangePercentage7d: coin.priceChangePercentage7d,
            priceChangePercentage1h: coin.priceChangePercentage1h,
            priceChangePercentage24h: coin.priceChangePercentage24h,
            priceChangePercentage30d: coin.priceChangePercentage30d,
            priceChangePercentage200d: coin.priceChangePercentage200d,
            priceChangePercentage1y: coin.priceChangePercentage1y,
            marketCapRank: coin.marketCapRank,
            circulatingSupply: coin.circulatingSupply,
            totalSupply: coin.totalSupply,
            maxSupply: coin.maxSupply,
            volume24h: coin.volume24h,
            marketCapDominance: coin.marketCapDominance,
            allTimeHigh: coin.allTimeHigh,
            allTimeLow: coin.allTimeLow,
            allTimeHighDate: coin.allTimeHighDate,
            allTimeLowDate: coin.allTimeLowDate,
            roiPercentage: coin.roi?.percentage,
            roiCurrency: coin.roi?.currency,
            roiTimes: coin.roi?.times,
            twitterFollowers: coin.socialData?.twitterFollowers,
            redditSubscribers: coin.socialData?.redditSubscribers,
            redditActiveUsers: coin.socialData?.redditActiveUsers,
            githubCommits: coin.socialData?.githubCommits,
            githubStars: coin.socialData?.githubStars,
            githubForks: coin.socialData?.githubForks,
            developerScore: coin.socialData?.developerScore,
            sentimentScore: coin.socialData?.sentimentScore,
            fearGreedIndex: coin.socialData?.fearGreedIndex,
            trendingRank: coin.socialData?.trendingRank,
            isInWatchlist: coin.isInWatchlist,
            isInPortfolio: coin.isInPortfolio,
            portfolioQuantity: coin.portfolioQuantity,
            portfolioValue: coin.portfolioValue,
            portfolioProfitLoss: coin.portfolioProfitLoss,
            portfolioProfitLossPercentage: coin.portfolioProfitLossPercentage
        )
    }
}
