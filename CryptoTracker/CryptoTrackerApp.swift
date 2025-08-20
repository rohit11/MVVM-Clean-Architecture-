//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Rohit Nisal on 7/24/25.
//

import SwiftUI
import SwiftData

// All UI components are imported from UIComponents.swift and EnhancedUIComponents.swift

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: CoinEntity.self)
    }
}
