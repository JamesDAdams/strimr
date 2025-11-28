import Combine
import SwiftUI

@MainActor
final class LibraryViewModel: ObservableObject {
    @Published var collections: [MediaItem]

    init(collections: [MediaItem] = MediaItem.samples) {
        self.collections = collections
    }
}

struct LibraryView: View {
    @StateObject var viewModel: LibraryViewModel
    let onSelectMedia: (MediaItem) -> Void

    init(
        viewModel: LibraryViewModel,
        onSelectMedia: @escaping (MediaItem) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSelectMedia = onSelectMedia
    }

    var body: some View {
        List(viewModel.collections) { item in
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
        .listStyle(.insetGrouped)
        .navigationTitle("Library")
    }
}

#Preview {
    NavigationStack {
        LibraryView(viewModel: LibraryViewModel())
    }
}
