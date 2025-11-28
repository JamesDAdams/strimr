import Combine
import SwiftUI

@MainActor
final class PlayerViewModel: ObservableObject {
    @Published var media: MediaItem
    @Published var isPlaying = false
    @Published var progress: Double = 0.35

    init(media: MediaItem) {
        self.media = media
    }

    func togglePlayback() {
        isPlaying.toggle()
    }
}

struct PlayerView: View {
    @StateObject var viewModel: PlayerViewModel
    let onClose: () -> Void

    init(viewModel: PlayerViewModel, onClose: @escaping () -> Void = {}) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onClose = onClose
    }

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Button(action: onClose) {
                    Image(systemName: "chevron.down")
                        .font(.title2)
                        .padding(8)
                        .contentShape(Rectangle())
                }
                Spacer()
            }

            VStack(spacing: 8) {
                Text("Now Playing")
                    .foregroundStyle(.secondary)
                Text(viewModel.media.title)
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
            }

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(.gray.opacity(0.3))
                .frame(height: 220)
                .overlay {
                    Text("Player Surface")
                        .foregroundStyle(.secondary)
                }

            VStack(spacing: 12) {
                Slider(value: $viewModel.progress, in: 0...1)
                HStack {
                    Text("0:00")
                    Spacer()
                    Text("N/A")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(.horizontal)

            HStack(spacing: 32) {
                Button {
                    viewModel.progress = max(0, viewModel.progress - 0.05)
                } label: {
                    Image(systemName: "gobackward.10")
                        .font(.title2)
                }

                Button {
                    viewModel.togglePlayback()
                } label: {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                }

                Button {
                    viewModel.progress = min(1, viewModel.progress + 0.05)
                } label: {
                    Image(systemName: "goforward.10")
                        .font(.title2)
                }
            }

            Spacer()
        }
        .padding(24)
        .navigationTitle("Player")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PlayerView(viewModel: PlayerViewModel(media: MediaItem.samples[0]))
    }
}
