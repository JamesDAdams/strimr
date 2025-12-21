import SwiftUI

struct LibraryRecommendedView: View {
    let onSelectMedia: (MediaItem) -> Void

    init(onSelectMedia: @escaping (MediaItem) -> Void = { _ in }) {
        self.onSelectMedia = onSelectMedia
    }

    var body: some View {
        ContentUnavailableView(
            "common.empty.nothingToShow",
            systemImage: "sparkles"
        )
    }
}

#Preview {
    LibraryRecommendedView(onSelectMedia: { _ in })
}
