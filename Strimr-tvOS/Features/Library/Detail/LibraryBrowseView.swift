import SwiftUI

struct LibraryBrowseView: View {
    let onSelectMedia: (MediaItem) -> Void

    init(onSelectMedia: @escaping (MediaItem) -> Void = { _ in }) {
        self.onSelectMedia = onSelectMedia
    }

    var body: some View {
        ContentUnavailableView(
            "library.browse.empty.title",
            systemImage: "square.grid.2x2.fill",
            description: Text("library.browse.empty.description")
        )
    }
}

#Preview {
    LibraryBrowseView(onSelectMedia: { _ in })
}
