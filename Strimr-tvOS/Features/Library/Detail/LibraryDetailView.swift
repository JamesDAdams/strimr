import SwiftUI

struct LibraryDetailView: View {
    let library: Library
    let onSelectMedia: (MediaItem) -> Void

    @State private var selectedTab: LibraryDetailTab = .recommended

    init(
        library: Library,
        onSelectMedia: @escaping (MediaItem) -> Void = { _ in }
    ) {
        self.library = library
        self.onSelectMedia = onSelectMedia
    }

    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Picker("library.detail.tabPicker", selection: $selectedTab) {
                    ForEach(LibraryDetailTab.allCases) { tab in
                        Text(tab.title).tag(tab)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 48)
                .padding(.top, 24)

                Group {
                    switch selectedTab {
                    case .recommended:
                        LibraryRecommendedView(onSelectMedia: onSelectMedia)
                    case .browse:
                        LibraryBrowseView(onSelectMedia: onSelectMedia)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
    }
}

enum LibraryDetailTab: String, CaseIterable, Identifiable {
    case recommended
    case browse

    var id: String {
        rawValue
    }

    var title: LocalizedStringKey {
        switch self {
        case .recommended:
            return "library.detail.tab.recommended"
        case .browse:
            return "library.detail.tab.browse"
        }
    }
}
