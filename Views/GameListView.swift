import SwiftUI

struct GameListView: View {
    @State private var games: [Game] = []
    @State private var searchText = ""
    private let service = GameService()

    var body: some View {
        NavigationView {
            VStack {
                // 🔍 Search bar
                TextField("Search for a game...", text: $searchText, onCommit: {
                    performSearch()
                })
                .padding(10)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding()

                // 🎮 Game list
                List(games, id: \.id) { game in
                    NavigationLink(destination: GameDetailView(game: game)) {
                        HStack {
                            AsyncImage(url: URL(string: game.background_image ?? "")) { image in
                                image.resizable().scaledToFill()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                            .clipped()

                            VStack(alignment: .leading) {
                                Text(game.name).bold()
                                Text("Rating: \(String(format: "%.1f", game.rating))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("202303103510365")
            .onAppear {
                fetchGames()
            }
        }
    }

    func fetchGames() {
        service.fetchGames { fetchedGames in
            self.games = fetchedGames
        }
    }

    func performSearch() {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            fetchGames()
            return
        }

        service.searchGames(query: searchText) { searchedGames in
            self.games = searchedGames
        }
    }
}
