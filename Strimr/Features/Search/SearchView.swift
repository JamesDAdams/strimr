import Combine
import SwiftUI

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var results: [MediaItem]

    init(results: [MediaItem] = MediaItem.samples) {
        self.results = results
    }

    func search() {
        guard !query.isEmpty else {
            results = MediaItem.samples
            return
        }

        results = MediaItem.samples.filter {
            $0.title.localizedCaseInsensitiveContains(query) ||
            $0.subtitle.localizedCaseInsensitiveContains(query)
        }
    }
}

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    let onSelectMedia: (MediaItem) -> Void

    init(
        viewModel: SearchViewModel,
        onSelectMedia: @escaping (MediaItem) -> Void = { _ in }
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSelectMedia = onSelectMedia
    }

    var body: some View {
        VStack {
            TextField("Search library", text: $viewModel.query)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .padding(.top, 8)
                .onSubmit { viewModel.search() }
                .onChange(of: viewModel.query) { _ in viewModel.search() }

            List(viewModel.results) { item in
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
            .listStyle(.plain)
        }
        .navigationTitle("Search")
    }
}

#Preview {
    NavigationStack {
        SearchView(viewModel: SearchViewModel())
    }
}
