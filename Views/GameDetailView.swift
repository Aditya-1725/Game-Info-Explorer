import SwiftUI

struct GameDetailView: View {
    let game: Game

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: game.background_image ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(maxWidth: .infinity)
                .cornerRadius(12)

                Text(game.name)
                    .font(.largeTitle)
                    .bold()

                if let released = game.released {
                    Text("📅 Released: \(released)")
                        .foregroundColor(.secondary)
                }

                Text("⭐️ Rating: \(String(format: "%.1f", game.rating))")
                    .foregroundColor(.orange)

                // Add more info here later: description, platforms, etc.
            }
            .padding()
        }
        .navigationTitle(game.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
