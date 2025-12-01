import Foundation
import Observation

@MainActor
@Observable
final class MediaImageViewModel {
    enum ArtworkKind: String {
        case thumb
        case art
    }

    @ObservationIgnored private let plexApi: PlexAPIManager
    var artworkKind: ArtworkKind
    var media: MediaItem
    private(set) var imageURL: URL? = nil


    init(plexApi: PlexAPIManager, artworkKind: ArtworkKind, media: MediaItem) {
        self.plexApi = plexApi
        self.artworkKind = artworkKind
        self.media = media
    }
    
    func load() async {
        guard let server = plexApi.server else {
            imageURL = nil
            return
        }

        let path: String?
        switch artworkKind {
        case .thumb:
            path = media.grandparentThumbPath ?? media.parentThumbPath ?? media.thumbPath
        case .art:
            path = media.grandparentArtPath  ?? media.artPath
        }

        guard let path else {
            imageURL = nil
            return
        }

        do {
            try await server.ensureConnection()
            imageURL = server.transcodeImageURL(path: path)
        } catch {
            imageURL = nil
        }
    }
}
