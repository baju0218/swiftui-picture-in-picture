import SwiftUI

struct StretchView<Content: View>: View {
    private let content: Content
    private let size: CGSize

    init(content: Content) {
        self.content = content
        self.size = content.size
    }

    var body: some View {
        GeometryReader { proxy in
            content
                .frame(width: size.width, height: size.height)
                .scaleEffect(
                    x: proxy.size.width / size.width,
                    y: proxy.size.height / size.height
                )
                .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
        }
    }
}
