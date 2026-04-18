import Foundation

struct GameResponse: Codable {
    let results: [Game]
}

struct Game: Codable, Identifiable {
    let id: Int
    let name: String
    let released: String?
    let rating: Double
    let background_image: String?
}
