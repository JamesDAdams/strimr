import SwiftUI

@main
struct StrimrApp: App {
    @StateObject private var sessionCoordinator = SessionCoordinator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sessionCoordinator)
                .preferredColorScheme(.dark)
        }
    }
}
