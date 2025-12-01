import SwiftUI

struct ContentView: View {
    @Environment(SessionManager.self) private var sessionManager
    @Environment(PlexAPIManager.self) private var plexApiManager

    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()

            switch sessionManager.status {
            case .hydrating:
                ProgressView("loading")
                    .progressViewStyle(.circular)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .signedOut:
#if os(tvOS)
                SignInTVView()
#else
                SignInView()
#endif
            case .needsServerSelection:
                SelectServerView(
                    viewModel: ServerSelectionViewModel(
                        sessionManager: sessionManager,
                        plexApiManager: plexApiManager
                    )
                )
            case .ready:
                MainTabView(
                    homeViewModel: HomeViewModel(plexApiManager: plexApiManager),
                    libraryViewModel: LibraryViewModel(plexApiManager: plexApiManager)
                )
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(SessionManager(apiManager: PlexAPIManager()))
}
