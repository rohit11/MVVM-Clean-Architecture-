import Foundation

struct NewsArticleDTO: Codable {
    let id: String
    let title: String
    let summary: String
    let content: String?
    let url: String
    let imageUrl: String?
    let publishedAt: String
    let source: String
    let category: String
    let sentiment: String
    let relatedCoins: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title, summary, content, url, source, category, sentiment
        case imageUrl = "image_url"
        case publishedAt = "published_at"
        case relatedCoins = "related_coins"
    }
    
    func toDomain() -> NewsArticle {
        let dateFormatter = ISO8601DateFormatter()
        let publishedDate = dateFormatter.date(from: publishedAt) ?? Date()
        
        return NewsArticle(
            id: id,
            title: title,
            summary: summary,
            content: content,
            url: url,
            imageUrl: imageUrl,
            publishedAt: publishedDate,
            source: source,
            category: NewsArticle.NewsCategory(rawValue: category) ?? .general,
            sentiment: NewsArticle.NewsSentiment(rawValue: sentiment) ?? .neutral,
            relatedCoins: relatedCoins
        )
    }
}
