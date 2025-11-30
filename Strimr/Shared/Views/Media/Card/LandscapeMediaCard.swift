import SwiftUI

struct LandscapeMediaCard: View {
    let media: MediaItem
    let imageURL: URL?
    let onTap: () -> Void

    var body: some View {
        MediaCard(layout: .landscape, media: media, imageURL: imageURL, onTap: onTap)
    }
}
