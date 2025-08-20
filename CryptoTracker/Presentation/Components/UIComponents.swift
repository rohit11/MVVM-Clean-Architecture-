import SwiftUI

// MARK: - Reusable UI Components

// MARK: - Card Component
struct CardView<Content: View>: View {
    let content: Content
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    
    init(
        backgroundColor: Color = Color(.secondarySystemBackground),
        cornerRadius: CGFloat = 12,
        shadowRadius: CGFloat = 2,
        @ViewBuilder content: () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .shadow(radius: shadowRadius)
    }
}

// MARK: - Price Display Component
struct PriceDisplayView: View {
    let price: String
    let changePercentage: Double?
    let showArrow: Bool
    let size: PriceSize
    
    enum PriceSize {
        case small, medium, large
        
        var font: Font {
            switch self {
            case .small: return .subheadline
            case .medium: return .headline
            case .large: return .system(size: 36, weight: .bold, design: .rounded)
            }
        }
    }
    
    init(
        price: String,
        changePercentage: Double? = nil,
        showArrow: Bool = true,
        size: PriceSize = .medium
    ) {
        self.price = price
        self.changePercentage = changePercentage
        self.showArrow = showArrow
        self.size = size
    }
    
    var body: some View {
        VStack(spacing: 4) {
            Text(price)
                .font(size.font)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            if let change = changePercentage {
                HStack(spacing: 4) {
                    if showArrow {
                        Image(systemName: change >= 0 ? "arrow.up.right" : "arrow.down.right")
                            .font(.caption)
                    }
                    
                    Text("\(change, specifier: "%.2f")%")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                .foregroundColor(change >= 0 ? .green : .red)
            }
        }
    }
}

// MARK: - Coin Image Component
struct CoinImageView: View {
    let imageURL: String
    let size: CGFloat
    let placeholderIcon: String
    
    init(
        imageURL: String,
        size: CGFloat = 40,
        placeholderIcon: String = "bitcoinsign.circle"
    ) {
        self.imageURL = imageURL
        self.size = size
        self.placeholderIcon = placeholderIcon
    }
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .overlay {
                    Image(systemName: placeholderIcon)
                        .font(.system(size: size * 0.4))
                        .foregroundColor(.gray)
                }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
    }
}

// MARK: - Loading State Component
struct LoadingView: View {
    let message: String
    let showSpinner: Bool
    
    init(message: String = "Loading...", showSpinner: Bool = true) {
        self.message = message
        self.showSpinner = showSpinner
    }
    
    var body: some View {
        VStack(spacing: 16) {
            if showSpinner {
                ProgressView()
                    .scaleEffect(1.5)
            }
            
            Text(message)
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Error State Component
struct ErrorView: View {
    let title: String
    let message: String
    let retryAction: () -> Void
    let iconName: String
    
    init(
        title: String = "Oops! Something went wrong",
        message: String,
        iconName: String = "exclamationmark.triangle",
        retryAction: @escaping () -> Void
    ) {
        self.title = title
        self.message = message
        self.iconName = iconName
        self.retryAction = retryAction
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: iconName)
                .font(.system(size: 50))
                .foregroundColor(.red)
            
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(message)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Retry", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

// MARK: - Empty State Component
struct EmptyStateView: View {
    let iconName: String
    let title: String
    let message: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: iconName)
                .font(.system(size: 40))
                .foregroundColor(.gray)
            
            Text(title)
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Search Bar Component
struct SearchBarView: View {
    @Binding var text: String
    let placeholder: String
    let onSearch: () -> Void
    let onClear: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: text) { _, _ in
                    onSearch()
                }
            
            if !text.isEmpty {
                Button("Clear") {
                    onClear()
                }
                .foregroundColor(.blue)
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Price Change Card Component
struct PriceChangeCardView: View {
    let title: String
    let percentage: Double?
    let showSign: Bool
    
    init(title: String, percentage: Double?, showSign: Bool = true) {
        self.title = title
        self.percentage = percentage
        self.showSign = showSign
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            if let percentage = percentage {
                HStack(spacing: 4) {
                    if showSign {
                        Text(percentage >= 0 ? "+" : "")
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    
                    Text("\(percentage, specifier: "%.2f")%")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundColor(percentage >= 0 ? .green : .red)
            } else {
                Text("N/A")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

// MARK: - Section Header Component
struct SectionHeaderView: View {
    let title: String
    let subtitle: String?
    
    init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - External Link Button Component
struct ExternalLinkButtonView: View {
    let title: String
    let iconName: String
    let url: URL
    let backgroundColor: Color
    
    init(
        title: String,
        iconName: String = "globe",
        url: URL,
        backgroundColor: Color = .blue
    ) {
        self.title = title
        self.iconName = iconName
        self.url = url
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        Link(destination: url) {
            HStack {
                Image(systemName: iconName)
                Text(title)
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .cornerRadius(12)
        }
    }
}
