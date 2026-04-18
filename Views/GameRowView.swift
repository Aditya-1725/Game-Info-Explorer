import SwiftUI

struct GameRowView: View {
    let game: Game

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: game.background_image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 100, height: 70)
            .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(game.name)
                    .font(.headline)

                if let released = game.released {
                    Text("Released: \(released)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Text("⭐️ Rating: \(String(format: "%.1f", game.rating))")
                    .font(.subheadline)
                    .foregroundColor(.orange)
            }
        }
        .padding(.vertical, 6)
    }
}
