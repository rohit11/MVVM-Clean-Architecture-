import SwiftUI

// MARK: - Enhanced UI Components

// MARK: - Statistics Grid Component
struct StatisticsGridView: View {
    let statistics: [StatisticItem]
    let columns: Int
    
    init(statistics: [StatisticItem], columns: Int = 2) {
        self.statistics = statistics
        self.columns = columns
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: columns), spacing: 16) {
            ForEach(statistics) { item in
                StatisticCardView(item: item)
            }
        }
    }
}

struct StatisticCardView: View {
    let item: StatisticItem
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: item.icon)
                    .foregroundColor(item.color)
                    .font(.title2)
                
                Spacer()
                
                if let trend = item.trend {
                    Image(systemName: trend.icon)
                        .foregroundColor(trend.color)
                        .font(.caption)
                }
            }
            
            Text(item.value)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(item.title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            if let subtitle = item.subtitle {
                Text(subtitle)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

// MARK: - Social Metrics Component
struct SocialMetricsView: View {
    let socialData: SocialData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(title: "Social & Sentiment", subtitle: "Community engagement and sentiment analysis")
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                SocialMetricCard(
                    title: "Twitter",
                    value: socialData.formattedTwitterFollowers,
                    icon: "bird",
                    color: .blue
                )
                
                SocialMetricCard(
                    title: "Reddit",
                    value: socialData.formattedRedditSubscribers,
                    icon: "person.3",
                    color: .orange
                )
                
                SocialMetricCard(
                    title: "GitHub",
                    value: socialData.formattedGithubStars,
                    icon: "chevron.left.forwardslash.chevron.right",
                    color: .purple
                )
                
                SocialMetricCard(
                    title: "Developer Score",
                    value: socialData.formattedDeveloperScore,
                    icon: "gearshape",
                    color: .green
                )
            }
            
            // Sentiment Section
            VStack(spacing: 12) {
                HStack {
                    Text("Sentiment Score")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text(socialData.formattedSentimentScore)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                
                HStack {
                    Text("Fear & Greed")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Circle()
                            .fill(socialData.fearGreedColor)
                            .frame(width: 12, height: 12)
                        
                        Text(socialData.fearGreedText)
                            .font(.subheadline)
                            .foregroundColor(socialData.fearGreedColor)
                    }
                }
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
        }
    }
}

struct SocialMetricCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

// MARK: - News Section Component
struct NewsSectionView: View {
    let news: [NewsArticle]
    let onNewsTap: (NewsArticle) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(title: "Latest News", subtitle: "Stay updated with the latest developments")
            
            if news.isEmpty {
                EmptyStateView(
                    iconName: "newspaper",
                    title: "No News Available",
                    message: "Check back later for updates"
                )
                .frame(height: 120)
            } else {
                LazyVStack(spacing: 12) {
                    ForEach(Array(news.prefix(5))) { article in
                        NewsCardView(article: article, onTap: onNewsTap)
                    }
                }
            }
        }
    }
}

struct NewsCardView: View {
    let article: NewsArticle
    let onTap: (NewsArticle) -> Void
    
    var body: some View {
        Button(action: { onTap(article) }) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(article.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                        
                        Text(article.summary)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        HStack {
                            Image(systemName: article.category.icon)
                                .foregroundColor(article.category.color)
                                .font(.caption)
                            
                            Text(article.category.displayName)
                                .font(.caption)
                                .foregroundColor(article.category.color)
                        }
                        
                        HStack {
                            Image(systemName: article.sentiment.icon)
                                .foregroundColor(article.sentiment.color)
                                .font(.caption)
                            
                            Text(article.sentiment.displayName)
                                .font(.caption)
                                .foregroundColor(article.sentiment.color)
                        }
                    }
                }
                
                HStack {
                    Text(article.source)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(article.timeAgo)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Portfolio Actions Component
struct PortfolioActionsView: View {
    let coin: Coin
    let onWatchlistToggle: () -> Void
    let onPortfolioAdd: () -> Void
    let onAlertSet: () -> Void
    let onShare: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(title: "Portfolio Actions", subtitle: "Manage your investments and alerts")
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 16) {
                PortfolioActionButton(
                    title: coin.isInWatchlist ? "Remove from Watchlist" : "Add to Watchlist",
                    icon: coin.isInWatchlist ? "eye.slash.fill" : "eye.fill",
                    color: coin.isInWatchlist ? .gray : .blue,
                    action: onWatchlistToggle
                )
                
                PortfolioActionButton(
                    title: coin.isInPortfolio ? "Update Portfolio" : "Add to Portfolio",
                    icon: coin.isInPortfolio ? "pencil.circle.fill" : "plus.circle.fill",
                    color: coin.isInPortfolio ? .orange : .green,
                    action: onPortfolioAdd
                )
                
                PortfolioActionButton(
                    title: "Set Price Alert",
                    icon: "bell.fill",
                    color: .purple,
                    action: onAlertSet
                )
                
                PortfolioActionButton(
                    title: "Share",
                    icon: "square.and.arrow.up",
                    color: .indigo,
                    action: onShare
                )
            }
            
            // Portfolio Stats (if coin is in portfolio)
            if coin.isInPortfolio {
                PortfolioStatsView(coin: coin)
            }
        }
    }
}

struct PortfolioActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(color)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PortfolioStatsView: View {
    let coin: Coin
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Portfolio Statistics")
                .font(.subheadline)
                .fontWeight(.semibold)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Quantity")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(coin.formattedCirculatingSupply)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                VStack(alignment: .center, spacing: 4) {
                    Text("Current Value")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(coin.formattedPortfolioValue)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("P&L")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(coin.formattedPortfolioProfitLoss)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(coin.portfolioProfitLossColor)
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
    }
}

// MARK: - Tabbed Content View
struct TabbedContentView<Content: View>: View {
    let title: String
    let tabs: [String]
    @Binding var selectedTab: Int
    let content: (Int) -> Content
    
    init(
        title: String,
        tabs: [String],
        selectedTab: Binding<Int>,
        @ViewBuilder content: @escaping (Int) -> Content
    ) {
        self.title = title
        self.tabs = tabs
        self._selectedTab = selectedTab
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 16) {
            SectionHeaderView(title: title)
            
            // Tab Selector
            HStack(spacing: 0) {
                ForEach(Array(tabs.enumerated()), id: \.offset) { index, tab in
                    Button(action: { selectedTab = index }) {
                        Text(tab)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(selectedTab == index ? .white : .primary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selectedTab == index ? Color.blue : Color.clear)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    if index < tabs.count - 1 {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
            
            // Tab Content
            content(selectedTab)
        }
    }
}
