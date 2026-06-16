import SwiftUI

extension View {
    @available(iOS 15.0, *)
    public func pictureInPicture<Content: View>(
        isPresented: Binding<Bool>,
        canStartAutomaticallyFromInline: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        background(
            PictureInPictureView(
                isPresented: isPresented,
                canStartAutomaticallyFromInline: canStartAutomaticallyFromInline,
                content: content
            )
        )
    }
}
