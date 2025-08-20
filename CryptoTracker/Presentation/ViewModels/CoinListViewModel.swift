import Foundation
import SwiftUI

// All UI components are imported from UIComponents.swift and EnhancedUIComponents.swift

@Observable
@MainActor
class CoinListViewModel {
    private let getTopCoinsUseCase: GetTopCoinsUseCase
    private let searchCoinsUseCase: SearchCoinsUseCase
    
    var coins: [Coin] = []
    var filteredCoins: [Coin] = []
    var isLoading = false
    var isRefreshing = false
    var errorMessage: String? = nil
    var searchText = ""
    
    init(getTopCoinsUseCase: GetTopCoinsUseCase, searchCoinsUseCase: SearchCoinsUseCase) {
        self.getTopCoinsUseCase = getTopCoinsUseCase
        self.searchCoinsUseCase = searchCoinsUseCase
    }
    
    func fetchCoins() async {
        isLoading = true
        errorMessage = nil
        
        do {
            coins = try await getTopCoinsUseCase.execute()
            filteredCoins = coins
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func refreshCoins() async {
        isRefreshing = true
        errorMessage = nil
        
        do {
            coins = try await getTopCoinsUseCase.refresh()
            filteredCoins = coins
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isRefreshing = false
    }
    
    func searchCoins() async {
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            filteredCoins = coins
            return
        }
        
        do {
            filteredCoins = try await searchCoinsUseCase.execute(query: searchText)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func clearSearch() {
        searchText = ""
        filteredCoins = coins
        errorMessage = nil
    }
    
    func retry() async {
        await fetchCoins()
    }
}
