import Combine
import SwiftUI

@MainActor
final class MediaDetailViewModel: ObservableObject {
    @Published var media: MediaItem
    @Published var overview: String

    init(media: MediaItem, overview: String = "Synopsis placeholder for upcoming media details.") {
        self.media = media
        self.overview = overview
    }

    var formattedDuration: String {
        guard let duration = media.duration else { return "N/A" }
        let minutes = Int(duration) / 60
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        if hours > 0 {
            return "\(hours)h \(remainingMinutes)m"
        }
        return "\(minutes)m"
    }
}

struct MediaDetailView: View {
    @StateObject var viewModel: MediaDetailViewModel
    let onPlay: (MediaItem) -> Void

    init(
        viewModel: MediaDetailViewModel,
        onPlay: @escaping (MediaItem) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onPlay = onPlay
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(.gray.opacity(0.3))
                    .frame(height: 220)
                    .overlay {
                        Text("Artwork")
                            .foregroundStyle(.secondary)
                    }

                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.media.title)
                        .font(.title.bold())

                    if !viewModel.media.subtitle.isEmpty {
                        Text(viewModel.media.subtitle)
                            .foregroundStyle(.secondary)
                    }

                    HStack(spacing: 12) {
                        if let year = viewModel.media.year {
                            Label(String(year), systemImage: "calendar")
                        }

                        Label(viewModel.formattedDuration, systemImage: "clock")

                        if let rating = viewModel.media.rating {
                            Label(String(format: "%.1f", rating), systemImage: "star.fill")
                        }
                    }
                    .foregroundStyle(.secondary)

                    if !viewModel.media.genres.isEmpty {
                        Text(viewModel.media.genres.joined(separator: " • "))
                            .foregroundStyle(.secondary)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Overview")
                        .font(.headline)
                    Text(viewModel.overview)
                        .foregroundStyle(.secondary)
                }

                Button {
                    onPlay(viewModel.media)
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Play")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.brandPrimary)
                    .foregroundStyle(.brandPrimaryForeground)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }

                Spacer()
            }
            .padding(20)
        }
        .navigationTitle(viewModel.media.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MediaDetailView(viewModel: MediaDetailViewModel(media: MediaItem.samples[0]))
    }
}
