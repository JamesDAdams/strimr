import SwiftUI

struct MediaCarousel<Content: View>: View {
    let items: [MediaItem]
    let cardWidthFraction: CGFloat
    let spacing: CGFloat
    let content: (MediaItem, CGFloat) -> Content

    init(
        items: [MediaItem],
        cardWidthFraction: CGFloat,
        spacing: CGFloat,
        @ViewBuilder content: @escaping (MediaItem, CGFloat) -> Content
    ) {
        self.items = items
        self.cardWidthFraction = cardWidthFraction
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        let cardWidth = UIScreen.main.bounds.width * cardWidthFraction

        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: spacing) {
                ForEach(items, id: \.id) { item in
                    content(item, cardWidth)
                }
            }
            .padding(.horizontal, 2)
        }
    }
}
