import SwiftUI

struct PlayerControlsView: View {
    @Binding var position: Double
    var duration: Double?
    var onEditingChanged: (Bool) -> Void
    
    private var sliderUpperBound: Double {
        max(duration ?? 0, position, 1)
    }
    
    private var sliderBinding: Binding<Double> {
        Binding(
            get: {
                min(position, sliderUpperBound)
            },
            set: { newValue in
                position = newValue
            }
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Slider(value: sliderBinding, in: 0...sliderUpperBound, onEditingChanged: onEditingChanged)
                .tint(.white)
                .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 8)
                .background(alignment: .center) {
                    Capsule()
                        .fill(Color.white.opacity(0.35))
                        .frame(height: 4)
                        .padding(.horizontal, 2)
                        .allowsHitTesting(false)
                }

            HStack {
                Text(elapsedText)
                Spacer()
                Text(remainingText)
            }
            .font(.footnote.monospacedDigit())
            .foregroundStyle(.white.opacity(0.9))
            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 32)
    }

    private var elapsedText: String {
        formatTime(position)
    }

    private var remainingText: String {
        guard let duration else { return "--:--" }
        let remaining = max(duration - position, 0)
        return "-\(formatTime(remaining))"
    }

    private func formatTime(_ seconds: Double) -> String {
        let totalSeconds = max(Int(seconds.rounded()), 0)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let secs = totalSeconds % 60

        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%02d:%02d", minutes, secs)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PlayerControlsView(position: .constant(15), duration: 60) { _ in }
    }
}
