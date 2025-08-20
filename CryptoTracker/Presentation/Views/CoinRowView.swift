import SwiftUI

// All UI components are imported from UIComponents.swift and EnhancedUIComponents.swift

struct CoinRowView: View {
    let coin: Coin
    
    var body: some View {
        HStack(spacing: 12) {
            // Coin Image using reusable component
            CoinImageView(
                imageURL: coin.image,
                size: 40,
                placeholderIcon: "bitcoinsign.circle"
            )
            
            // Coin Info
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(coin.symbol.uppercased())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Price Info using reusable component
            PriceDisplayView(
                price: coin.formattedPrice,
                changePercentage: coin.priceChangePercentage7d,
                showArrow: true,
                size: .medium
            )
            
            // Market Cap
            if let marketCap = coin.marketCap {
                Text("MCap: $\(Int(marketCap))")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}
