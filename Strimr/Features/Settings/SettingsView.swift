import SwiftUI

@MainActor
struct SettingsView: View {
    @Environment(SettingsManager.self) private var settingsManager

    private let seekOptions = [5, 10, 15, 30, 45, 60]

    private var autoPlayNextBinding: Binding<Bool> {
        Binding(
            get: { settingsManager.playback.autoPlayNextEpisode },
            set: { settingsManager.setAutoPlayNextEpisode($0) }
        )
    }

    private var rewindBinding: Binding<Int> {
        Binding(
            get: { settingsManager.playback.seekBackwardSeconds },
            set: { settingsManager.setSeekBackwardSeconds($0) }
        )
    }

    private var fastForwardBinding: Binding<Int> {
        Binding(
            get: { settingsManager.playback.seekForwardSeconds },
            set: { settingsManager.setSeekForwardSeconds($0) }
        )
    }

    var body: some View {
        List {
            Section("Playback") {
                Toggle("Play next episode automatically", isOn: autoPlayNextBinding)

                Picker("Rewind", selection: rewindBinding) {
                    ForEach(seekOptions, id: \.self) { seconds in
                        Text("\(seconds) seconds").tag(seconds)
                    }
                }

                Picker("Fast forward", selection: fastForwardBinding) {
                    ForEach(seekOptions, id: \.self) { seconds in
                        Text("\(seconds) seconds").tag(seconds)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environment(SettingsManager())
    }
}
