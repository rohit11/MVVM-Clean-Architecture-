# CryptoTracker - Modern iOS App

A cryptocurrency tracking app built with **SwiftUI**, **Clean Architecture**, **MVVM**, and modern Swift concepts.

## 🚀 Features

- **Top 100 Cryptocurrencies** by market cap
- **Real-time Data** from CoinGecko API
- **Offline Support** with SwiftData persistence
- **Search Functionality** across all coins
- **Pull-to-Refresh** for latest data
- **Beautiful UI** with modern design patterns
- **Comprehensive Error Handling** with user-friendly messages

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
┌─────────────────────────────────────┐
│           Presentation Layer        │ ← Views + ViewModels
├─────────────────────────────────────┤
│           Domain Layer              │ ← Use Cases + Entities + Repositories (protocols)
├─────────────────────────────────────┤
│           Data Layer                │ ← Repositories (implementations) + Data Sources
└─────────────────────────────────────┘
```

### **Layer Breakdown**

#### **Domain Layer**
- **Entities**: Pure business models (`Coin`)
- **Use Cases**: Business logic (`GetTopCoinsUseCase`, `SearchCoinsUseCase`)
- **Repository Protocols**: Abstract data access contracts

#### **Data Layer**
- **Data Sources**: Remote API (`CoinRemoteDataSource`) and Local Storage (`CoinLocalDataSource`)
- **DTOs**: Data Transfer Objects for API responses
- **SwiftData Entities**: Local persistence models
- **Repository Implementation**: Concrete repository with offline-first approach

#### **Presentation Layer**
- **Views**: SwiftUI views with modern UI patterns
- **ViewModels**: `@Observable` classes using the Observation framework
- **State Management**: Reactive state with async/await

## 🛠️ Technical Stack

- **iOS 17.0+** (Minimum target)
- **SwiftUI** for modern declarative UI
- **SwiftData** for local persistence
- **Observation Framework** for reactive state management
- **Async/Await** for modern concurrency
- **Dependency Injection** for testable architecture
- **URLSession** for network requests

## 📱 Screenshots

### Main List View
- Displays top 100 cryptocurrencies
- Search functionality with real-time filtering
- Pull-to-refresh for latest data
- Beautiful card-based design

### Detail View
- Comprehensive coin information
- Price change percentages across multiple time periods
- Market cap and ranking information
- Direct link to CoinGecko

## 🔧 Setup & Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd CryptoTracker
   ```

2. **Open in Xcode**
   - Open `CryptoTracker.xcodeproj`
   - Ensure iOS deployment target is set to 17.0+

3. **Build and Run**
   - Select your target device/simulator
   - Press Cmd+R to build and run

## 🧪 Testing

The project includes comprehensive testing:

- **Unit Tests**: Domain models, use cases, and business logic
- **UI Tests**: User interface validation
- **Maestro Flow**: Automated UI testing scenarios

Run tests with:
```bash
# Unit tests
xcodebuild test -scheme CryptoTracker -destination 'platform=iOS Simulator,name=iPhone 15'

# UI tests
xcodebuild test -scheme CryptoTrackerUITests -destination 'platform=iOS Simulator,name=iPhone 15'
```

## 🏗️ Project Structure

```
CryptoTracker/
├── CryptoTracker/
│   ├── Configuration/
│   │   └── ProjectConfig.swift
│   ├── DI/
│   │   └── DIContainer.swift
│   ├── Domain/
│   │   ├── Entities/
│   │   │   ├── Coin.swift
│   │   │   └── CoinError.swift
│   │   ├── Repositories/
│   │   │   └── CoinRepository.swift
│   │   └── UseCases/
│   │       ├── GetTopCoinsUseCase.swift
│   │       └── SearchCoinsUseCase.swift
│   ├── Data/
│   │   ├── DTOs/
│   │   │   └── CoinDTO.swift
│   │   ├── Entities/
│   │   │   └── CoinEntity.swift
│   │   ├── DataSources/
│   │   │   ├── CoinRemoteDataSource.swift
│   │   │   └── CoinLocalDataSource.swift
│   │   └── Repositories/
│   │       └── CoinRepositoryImpl.swift
│   ├── Presentation/
│   │   ├── ViewModels/
│   │   │   ├── CoinListViewModel.swift
│   │   │   └── CoinDetailViewModel.swift
│   │   └── Views/
│   │       ├── CryptoListView.swift
│   │       ├── CoinRowView.swift
│   │       └── CryptoDetailView.swift
│   ├── ContentView.swift
│   └── CryptoTrackerApp.swift
├── CryptoTrackerTests/
│   └── CryptoTrackerTests.swift
└── CryptoTrackerUITests/
    ├── CryptoTrackerUITests.swift
    └── maestro-flow.yaml
```

## 🔄 Data Flow

1. **App Launch**: SwiftData container initialized
2. **Data Fetching**: Repository checks local cache first
3. **API Call**: If cache is stale, fetches from CoinGecko
4. **Local Storage**: New data saved to SwiftData
5. **UI Update**: ViewModels update with new data
6. **Offline Support**: App works with cached data when offline

## 🎯 Key Benefits

### **For Developers**
- **Testable**: Easy to mock dependencies and test business logic
- **Maintainable**: Clear separation of concerns
- **Scalable**: Easy to add new features and data sources
- **Modern**: Uses latest Swift and iOS features

### **For Users**
- **Fast**: Offline-first approach with local caching
- **Reliable**: Comprehensive error handling and recovery
- **Beautiful**: Modern, intuitive interface
- **Responsive**: Pull-to-refresh and real-time search

## 🚀 Future Enhancements

- **Price Alerts**: Push notifications for price changes
- **Portfolio Tracking**: Personal coin portfolios
- **Charts**: Interactive price charts with multiple timeframes
- **Favorites**: Save favorite cryptocurrencies
- **Dark Mode**: Enhanced theme support
- **Widgets**: iOS home screen widgets

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

For support, email support@cryptotracker.com or create an issue in this repository.

---

**Built with ❤️ using modern iOS development practices**
