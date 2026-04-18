import Foundation

class GameService {
    
    // MARK: - Fetch Default Game List
    func fetchGames(completion: @escaping ([Game]) -> Void) {
        let urlString = "\(Constants.baseURL)/games?key=\(Constants.apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL for game list")
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching games: \(error)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received from game API")
                completion([])
                return
            }

            do {
                let decoded = try JSONDecoder().decode(GameResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded.results)
                }
            } catch {
                print("Failed to decode game list: \(error)")
                completion([])
            }
        }.resume()
    }
    
    // MARK: - Search Games by Query
    func searchGames(query: String, completion: @escaping ([Game]) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(Constants.baseURL)/games?key=\(Constants.apiKey)&search=\(encodedQuery)"

        guard let url = URL(string: urlString) else {
            print("Invalid search URL")
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error searching games: \(error)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received from search")
                completion([])
                return
            }

            do {
                let decoded = try JSONDecoder().decode(GameResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded.results)
                }
            } catch {
                print("Failed to decode search results: \(error)")
                completion([])
            }
        }.resume()
    }
}
