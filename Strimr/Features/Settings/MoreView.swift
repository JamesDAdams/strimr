import SwiftUI

enum MoreRoute: Hashable {
    case settings
}

@MainActor
struct MoreView: View {
    @Environment(SessionManager.self) private var sessionManager
    @State private var isShowingLogoutConfirmation = false
    var onSwitchProfile: () -> Void = {}
    var onSwitchServer: () -> Void = {}

    var body: some View {
        List {
            Section {
                NavigationLink(value: MoreRoute.settings) {
                    Label("Settings", systemImage: "gearshape.fill")
                }

                Button(action: onSwitchProfile) {
                    Label("Switch Profile", systemImage: "person.2.circle")
                }
                .buttonStyle(.plain)

                Button(action: onSwitchServer) {
                    Label("Switch Server", systemImage: "server.rack")
                }
                .buttonStyle(.plain)

                Button {
                    isShowingLogoutConfirmation = true
                } label: {
                    Label("Log Out", systemImage: "arrow.backward.circle")
                }
                .buttonStyle(.plain)
                .tint(.red)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("More")
        .alert("Log Out", isPresented: $isShowingLogoutConfirmation) {
            Button("Log Out", role: .destructive) {
                Task { await sessionManager.signOut() }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("You will need to sign in again.")
        }
    }
}

#Preview {
    NavigationStack {
        MoreView()
            .navigationDestination(for: MoreRoute.self) { route in
                switch route {
                case .settings:
                    EmptyView()
                }
            }
    }
}
