import Foundation

protocol CoinRemoteDataSource {
    func fetchTopCoins() async throws -> [CoinDTO]
    func searchCoins(query: String) async throws -> [CoinDTO]
}

struct CoinRemoteDataSourceImpl: CoinRemoteDataSource {
    private let baseURL = "https://api.coingecko.com/api/v3"
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchTopCoins() async throws -> [CoinDTO] {
        let urlString = "\(baseURL)/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h,24h,7d,30d,200d,1y"
        
        guard let url = URL(string: urlString) else {
            throw CoinError.invalidData("Invalid URL")
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw CoinError.networkError("Invalid response")
            }
            
            guard httpResponse.statusCode == 200 else {
                throw CoinError.serverError(httpResponse.statusCode)
            }
            
            let coins = try JSONDecoder().decode([CoinDTO].self, from: data)
            return coins
        } catch let error as CoinError {
            throw error
        } catch {
            if let urlError = error as? URLError {
                switch urlError.code {
                case .notConnectedToInternet, .networkConnectionLost:
                    throw CoinError.noInternetConnection
                default:
                    throw CoinError.networkError(urlError.localizedDescription)
                }
            }
            throw CoinError.decodingError(error.localizedDescription)
        }
    }
    
    func searchCoins(query: String) async throws -> [CoinDTO] {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let urlString = "\(baseURL)/search?query=\(encodedQuery)"
        
        guard let url = URL(string: urlString) else {
            throw CoinError.invalidData("Invalid URL")
        }
        
        do {
            let (data, response) = try await session.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw CoinError.networkError("Invalid response")
            }
            
            guard httpResponse.statusCode == 200 else {
                throw CoinError.serverError(httpResponse.statusCode)
            }
            
            // Note: Search endpoint returns different structure, simplified for demo
            let coins = try JSONDecoder().decode([CoinDTO].self, from: data)
            return coins
        } catch {
            throw CoinError.decodingError(error.localizedDescription)
        }
    }
}
