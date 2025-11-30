import SwiftUI

struct PortraitMediaCard: View {
    let media: MediaItem
    let onTap: () -> Void

    var body: some View {
        MediaCard(layout: .portrait, media: media, imageURL: imageURL, onTap: onTap)
    }
}
