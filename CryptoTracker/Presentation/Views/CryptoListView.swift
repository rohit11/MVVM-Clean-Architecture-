import SwiftUI
import SwiftData

// All UI components are imported from UIComponents.swift and EnhancedUIComponents.swift

struct CryptoListView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: CoinListViewModel?
    
    var body: some View {
        NavigationView {
            Group {
                if let viewModel = viewModel {
                    mainContent(viewModel)
                } else {
                    LoadingView(message: "Initializing...")
                }
            }
            .navigationTitle("Top 100 Crypto")
        }
        .onAppear {
            if viewModel == nil {
                Task { @MainActor in
                    viewModel = await DIContainer.shared.coinListViewModel(modelContext: modelContext)
                    await viewModel?.fetchCoins()
                }
            }
        }
    }
    
    @ViewBuilder
    private func mainContent(_ viewModel: CoinListViewModel) -> some View {
        VStack {
            // Search Bar using reusable component
            SearchBarView(
                text: Binding(
                    get: { viewModel.searchText },
                    set: { viewModel.searchText = $0 }
                ),
                placeholder: "Search coins...",
                onSearch: {
                    Task {
                        await viewModel.searchCoins()
                    }
                },
                onClear: {
                    viewModel.clearSearch()
                }
            )
            
            // Content
            if viewModel.isLoading && viewModel.coins.isEmpty {
                LoadingView(message: "Loading cryptocurrencies...")
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(
                    message: errorMessage,
                    retryAction: {
                        Task {
                            await viewModel.retry()
                        }
                    }
                )
            } else {
                coinList(viewModel)
            }
        }
        .refreshable {
            await viewModel.refreshCoins()
        }
    }
    
    @ViewBuilder
    private func coinList(_ viewModel: CoinListViewModel) -> some View {
        List {
            ForEach(viewModel.filteredCoins) { coin in
                NavigationLink(destination: CryptoDetailView(coin: coin)) {
                    CoinRowView(coin: coin)
                }
            }
        }
        .listStyle(PlainListStyle())
        .overlay {
            if viewModel.filteredCoins.isEmpty && !viewModel.searchText.isEmpty {
                EmptyStateView(
                    iconName: "magnifyingglass",
                    title: "No coins found",
                    message: "Try adjusting your search terms"
                )
            }
        }
    }
}
