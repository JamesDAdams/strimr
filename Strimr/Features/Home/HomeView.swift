import Combine
import SwiftUI

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var featuredItems: [MediaItem]

    init(featuredItems: [MediaItem] = MediaItem.samples) {
        self.featuredItems = featuredItems
    }
}

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    let onSelectMedia: (MediaItem) -> Void

    init(
        viewModel: HomeViewModel,
        onSelectMedia: @escaping (MediaItem) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSelectMedia = onSelectMedia
    }

    var body: some View {
        List {
            Section("Featured") {
                ForEach(viewModel.featuredItems) { item in
                    Button {
                        onSelectMedia(item)
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.subtitle)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Home")
    }
}

#Preview {
    NavigationStack {
        HomeView(viewModel: HomeViewModel())
    }
}
