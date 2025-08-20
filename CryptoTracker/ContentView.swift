//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Rohit Nisal on 7/24/25.
//

import SwiftUI

// All UI components are imported from UIComponents.swift and EnhancedUIComponents.swift

struct ContentView: View {
    var body: some View {
        CryptoListView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: CoinEntity.self, inMemory: true)
}
