import SwiftUI

struct MainTabTVView: View {
    @Environment(SessionManager.self) private var sessionManager
    @Environment(PlexAPIContext.self) private var plexApiContext
    @StateObject private var coordinator = MainCoordinator()
    @State private var selectedMedia: MediaItem?

    var body: some View {
        TabView(selection: $coordinator.tab) {
            NavigationStack {
                HomeTVView(
                    viewModel: HomeViewModel(context: plexApiContext),
                    onSelectMedia: showMediaDetail
                )
            }
            .tabItem { Label("tabs.home", systemImage: "house.fill") }
            .tag(MainCoordinator.Tab.home)

            NavigationStack {
                SearchTVView(
                    viewModel: SearchViewModel(context: plexApiContext),
                    onSelectMedia: showMediaDetail
                )
            }
            .tabItem { Label("tabs.search", systemImage: "magnifyingglass") }
            .tag(MainCoordinator.Tab.search)

            NavigationStack {
                ZStack {
                    Color("Background")
                        .ignoresSafeArea()

                    LibraryTVView(
                        viewModel: LibraryViewModel(context: plexApiContext),
                        onSelectMedia: showMediaDetail
                    )
                    .navigationDestination(for: Library.self) { library in
                        LibraryDetailView(
                            library: library,
                            onSelectMedia: showMediaDetail
                        )
                    }
                }
            }
            .tabItem { Label("tabs.libraries", systemImage: "rectangle.stack.fill") }
            .tag(MainCoordinator.Tab.library)

            NavigationStack {
                moreView
            }
            .tabItem { Label("tabs.more", systemImage: "ellipsis.circle") }
            .tag(MainCoordinator.Tab.more)
        }
        .fullScreenCover(item: $selectedMedia) { media in
            MediaDetailTVView(
                viewModel: MediaDetailViewModel(media: media, context: plexApiContext),
                onSelectMedia: showMediaDetail
            )
        }
    }

    private var moreView: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("tabs.more")
                        .font(.largeTitle.bold())
                    Text("Manage your session while we finish the tvOS experience.")
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 8)

                    Button {
                        Task { await sessionManager.requestProfileSelection() }
                    } label: {
                        Label("common.actions.switchProfile", systemImage: "person.2.fill")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)

                    Button {
                        Task { await sessionManager.requestServerSelection() }
                    } label: {
                        Label("serverSelection.title", systemImage: "server.rack")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)

                    Button {
                        Task { await sessionManager.signOut() }
                    } label: {
                        Label("common.actions.signOut", systemImage: "rectangle.portrait.and.arrow.right")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)

                    Spacer()
                }
                .padding(48)
            }
        }
    }

    private func showMediaDetail(_ media: MediaItem) {
        selectedMedia = media
    }
}
