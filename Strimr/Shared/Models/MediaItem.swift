import Foundation

struct MediaItem: Identifiable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let genres: [String]
    let year: Int?
    let duration: TimeInterval?
    let rating: Double?

    static let samples: [MediaItem] = [
        MediaItem(
            id: UUID(uuidString: "E47D2C53-2A18-42F3-A0D5-6E55FC3C6BE2") ?? UUID(),
            title: "Sample Film",
            subtitle: "A future blockbuster ready for playback.",
            genres: ["Action", "Adventure"],
            year: 2024,
            duration: 7_200,
            rating: 4.7
        ),
        MediaItem(
            id: UUID(uuidString: "8C61D8C4-D6D0-4A90-9875-5B9C489F74AC") ?? UUID(),
            title: "Sample Series",
            subtitle: "Season 1 of a yet-to-be-fetched favorite.",
            genres: ["Drama"],
            year: 2023,
            duration: 3_600,
            rating: 4.3
        ),
        MediaItem(
            id: UUID(uuidString: "A3A34E6C-12D9-4F6B-8BA4-2E38C7A0C8B6") ?? UUID(),
            title: "Sample Documentary",
            subtitle: "An informative story placeholder.",
            genres: ["Documentary"],
            year: 2022,
            duration: 5_400,
            rating: 4.1
        )
    ]
}
