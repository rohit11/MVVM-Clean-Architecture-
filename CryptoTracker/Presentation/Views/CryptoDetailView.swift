import SwiftUI

// All UI components are imported from UIComponents.swift and EnhancedUIComponents.swift
// StatisticItem is imported from SharedTypes.swift

struct CryptoDetailView: View {
    let coin: Coin
    @State private var viewModel: CoinDetailViewModel?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                if let viewModel = viewModel {
                    coinHeader(viewModel)
                    priceSection(viewModel)
                    priceChangesSection(viewModel)
                    
                    // Tabbed Content
                    TabbedContentView(
                        title: "Detailed Information",
                        tabs: ["Market Data", "Social & Sentiment", "News", "Portfolio"],
                        selectedTab: Binding(
                            get: { viewModel.selectedTab },
                            set: { viewModel.selectedTab = $0 }
                        )
                    ) { selectedTab in
                        switch selectedTab {
                        case 0:
                            marketDataSection(viewModel)
                        case 1:
                            socialSentimentSection(viewModel)
                        case 2:
                            newsSection(viewModel)
                        case 3:
                            portfolioSection(viewModel)
                        default:
                            EmptyView()
                        }
                    }
                    
                    externalLinkSection(viewModel)
                } else {
                    LoadingView()
                }
            }
            .padding()
        }
        .navigationTitle(coin.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if viewModel == nil {
                Task { @MainActor in
                    viewModel = await DIContainer.shared.coinDetailViewModel(coin: coin)
                    await viewModel?.loadNews()
                }
            }
        }
        .refreshable {
            await viewModel?.loadNews()
        }
    }
    
    // MARK: - Header Section
    @ViewBuilder
    private func coinHeader(_ viewModel: CoinDetailViewModel) -> some View {
        VStack(spacing: 16) {
            // Coin Image
            CoinImageView(
                imageURL: coin.image,
                size: 80,
                placeholderIcon: "bitcoinsign.circle"
            )
            
            // Coin Name and Symbol
            VStack(spacing: 8) {
                Text(coin.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text(coin.symbol.uppercased())
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .fontWeight(.medium)
            }
        }
    }
    
    // MARK: - Price Section
    @ViewBuilder
    private func priceSection(_ viewModel: CoinDetailViewModel) -> some View {
        CardView {
            VStack(spacing: 12) {
                Text("Current Price")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                PriceDisplayView(
                    price: viewModel.formattedPrice,
                    changePercentage: coin.priceChangePercentage7d,
                    showArrow: false,
                    size: .large
                )
                .foregroundColor(coin.priceChangeColor)
            }
        }
    }
    
    // MARK: - Price Changes Section
    @ViewBuilder
    private func priceChangesSection(_ viewModel: CoinDetailViewModel) -> some View {
        CardView {
            VStack(alignment: .leading, spacing: 16) {
                SectionHeaderView(title: "Price Changes")
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    PriceChangeCardView(title: "1 Hour", percentage: coin.priceChangePercentage1h)
                    PriceChangeCardView(title: "24 Hours", percentage: coin.priceChangePercentage24h)
                    PriceChangeCardView(title: "7 Days", percentage: coin.priceChangePercentage7d)
                    PriceChangeCardView(title: "30 Days", percentage: coin.priceChangePercentage30d)
                    PriceChangeCardView(title: "200 Days", percentage: coin.priceChangePercentage200d)
                    PriceChangeCardView(title: "1 Year", percentage: coin.priceChangePercentage1y)
                }
            }
        }
    }
    
    // MARK: - Market Data Section
    @ViewBuilder
    private func marketDataSection(_ viewModel: CoinDetailViewModel) -> some View {
        CardView {
            VStack(alignment: .leading, spacing: 16) {
                SectionHeaderView(title: "Market Statistics", subtitle: "Comprehensive market data and metrics")
                
                StatisticsGridView(statistics: viewModel.marketStatistics, columns: 2)
            }
        }
    }
    
    // MARK: - Social & Sentiment Section
    @ViewBuilder
    private func socialSentimentSection(_ viewModel: CoinDetailViewModel) -> some View {
        if let socialData = coin.socialData {
            CardView {
                SocialMetricsView(socialData: socialData)
            }
        } else {
            CardView {
                EmptyStateView(
                    iconName: "person.3",
                    title: "No Social Data",
                    message: "Social metrics not available for this coin"
                )
                .frame(height: 120)
            }
        }
    }
    
    // MARK: - News Section
    @ViewBuilder
    private func newsSection(_ viewModel: CoinDetailViewModel) -> some View {
        CardView {
            if viewModel.isLoadingNews {
                LoadingView(message: "Loading news...", showSpinner: true)
                    .frame(height: 120)
            } else if let error = viewModel.newsError {
                ErrorView(
                    title: "Failed to Load News",
                    message: error,
                    retryAction: {
                        Task {
                            await viewModel.loadNews()
                        }
                    }
                )
                .frame(height: 120)
            } else {
                NewsSectionView(
                    news: viewModel.news,
                    onNewsTap: viewModel.onNewsTap
                )
            }
        }
    }
    
    // MARK: - Portfolio Section
    @ViewBuilder
    private func portfolioSection(_ viewModel: CoinDetailViewModel) -> some View {
        CardView {
            PortfolioActionsView(
                coin: coin,
                onWatchlistToggle: {
                    Task {
                        await viewModel.toggleWatchlist()
                    }
                },
                onPortfolioAdd: {
                    Task {
                        await viewModel.addToPortfolio()
                    }
                },
                onAlertSet: {
                    Task {
                        await viewModel.setPriceAlert()
                    }
                },
                onShare: {
                    viewModel.shareCoin()
                }
            )
        }
    }
    
    // MARK: - External Links Section
    @ViewBuilder
    private func externalLinkSection(_ viewModel: CoinDetailViewModel) -> some View {
        if let url = viewModel.coinGeckoURL {
            CardView {
                VStack(spacing: 12) {
                    SectionHeaderView(title: "More Information")
                    
                    ExternalLinkButtonView(
                        title: "View on CoinGecko",
                        iconName: "globe",
                        url: url,
                        backgroundColor: .blue
                    )
                }
            }
        }
    }
}
