import SwiftUI

extension View {
    /// Presents a Picture in Picture window containing the given SwiftUI content.
    ///
    /// Attach this modifier to any view to enable a system Picture in Picture
    /// overlay that hosts arbitrary SwiftUI content — not just video. The
    /// overlay is toggled through the `isPresented` binding, and the system
    /// keeps that binding in sync when the user closes the overlay manually.
    ///
    /// ```swift
    /// struct PlayerScreen: View {
    ///     @State private var isPiP = false
    ///
    ///     var body: some View {
    ///         PlayerView()
    ///             .pictureInPicture(
    ///                 isPresented: $isPiP,
    ///                 canStartAutomaticallyFromInline: true
    ///             ) {
    ///                 PlayerOverlayContent()
    ///             }
    ///     }
    /// }
    /// ```
    ///
    /// - Important: Picture in Picture requires host-app configuration that
    ///   this library cannot provide on its own:
    ///   1. Enable the **Audio, AirPlay, and Picture in Picture** background
    ///      mode in *Signing & Capabilities*.
    ///   2. Activate an `AVAudioSession` with a category that supports
    ///      background playback (`.playback` or `.playAndRecord`) before
    ///      starting Picture in Picture.
    ///
    ///   Picture in Picture is not supported in the iOS Simulator; test on a
    ///   physical device.
    ///
    /// - Parameters:
    ///   - isPresented: A binding that drives the Picture in Picture window.
    ///     Setting it to `true` starts the overlay; setting it to `false`
    ///     stops it. The binding is written back to `false` automatically
    ///     when the user closes the overlay from the system UI.
    ///   - canStartAutomaticallyFromInline: When `true`, the system may start
    ///     Picture in Picture automatically as the app transitions to the
    ///     background. Defaults to `false`.
    ///   - content: A view builder that produces the SwiftUI view to display
    ///     inside the Picture in Picture window.
    ///
    /// - Returns: A view that overlays a Picture in Picture window when
    ///   `isPresented` is `true`.
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
