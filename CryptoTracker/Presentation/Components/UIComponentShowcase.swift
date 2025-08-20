import SwiftUI

// MARK: - UI Component Showcase
// This view demonstrates all reusable UI components
// Perfect for testing and showcasing component variations

struct UIComponentShowcase: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Card Components
                showcaseSection("Card Components") {
                    VStack(spacing: 16) {
                        CardView {
                            Text("Default Card")
                                .font(.headline)
                        }
                        
                        CardView(
                            backgroundColor: .blue.opacity(0.1),
                            cornerRadius: 20,
                            shadowRadius: 5
                        ) {
                            Text("Custom Styled Card")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                // Price Display Components
                showcaseSection("Price Display Components") {
                    VStack(spacing: 16) {
                        PriceDisplayView(
                            price: "$50,000.00",
                            changePercentage: 5.5,
                            size: .large
                        )
                        
                        PriceDisplayView(
                            price: "$2,500.00",
                            changePercentage: -2.3,
                            size: .medium
                        )
                        
                        PriceDisplayView(
                            price: "$100.00",
                            size: .small
                        )
                    }
                }
                
                // Coin Image Components
                showcaseSection("Coin Image Components") {
                    HStack(spacing: 20) {
                        CoinImageView(
                            imageURL: "https://example.com/bitcoin.png",
                            size: 60,
                            placeholderIcon: "bitcoinsign.circle"
                        )
                        
                        CoinImageView(
                            imageURL: "invalid-url",
                            size: 60,
                            placeholderIcon: "ethereum.circle"
                        )
                    }
                }
                
                // Loading & Error States
                showcaseSection("Loading & Error States") {
                    VStack(spacing: 16) {
                        LoadingView(message: "Custom loading message...")
                            .frame(height: 100)
                        
                        ErrorView(
                            title: "Custom Error",
                            message: "This is a custom error message",
                            iconName: "xmark.circle",
                            retryAction: { print("Retry tapped") }
                        )
                        .frame(height: 200)
                    }
                }
                
                // Empty State
                showcaseSection("Empty State") {
                    EmptyStateView(
                        iconName: "tray",
                        title: "No Items",
                        message: "There are no items to display"
                    )
                    .frame(height: 150)
                }
                
                // Search Bar
                showcaseSection("Search Bar") {
                    SearchBarView(
                        text: .constant(""),
                        placeholder: "Search...",
                        onSearch: { print("Search triggered") },
                        onClear: { print("Clear tapped") }
                    )
                }
                
                // Price Change Cards
                showcaseSection("Price Change Cards") {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        PriceChangeCardView(title: "1H", percentage: 2.5)
                        PriceChangeCardView(title: "24H", percentage: -1.8)
                        PriceChangeCardView(title: "7D", percentage: 15.2)
                        PriceChangeCardView(title: "30D", percentage: nil)
                    }
                }
                
                // Section Headers
                showcaseSection("Section Headers") {
                    VStack(spacing: 16) {
                        SectionHeaderView(title: "Simple Header")
                        SectionHeaderView(
                            title: "Header with Subtitle",
                            subtitle: "This is a subtitle description"
                        )
                    }
                }
                
                // External Link Button
                showcaseSection("External Link Button") {
                    ExternalLinkButtonView(
                        title: "Visit Website",
                        iconName: "link",
                        url: URL(string: "https://example.com")!,
                        backgroundColor: .green
                    )
                }
            }
            .padding()
        }
        .navigationTitle("UI Components")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func showcaseSection<Content: View>(
        _ title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationView {
        UIComponentShowcase()
    }
}
