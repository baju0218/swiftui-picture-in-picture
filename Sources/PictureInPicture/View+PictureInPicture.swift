import SwiftUI

extension View {
    @available(iOS 15.0, *)
    public func pictureInPicture<Content: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        background(
            PictureInPictureView(isPresented: isPresented, content: content)
        )
    }
}
