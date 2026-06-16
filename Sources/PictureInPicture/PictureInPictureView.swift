import SwiftUI

@available(iOS 15.0, *)
struct PictureInPictureView<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let canStartAutomaticallyFromInline: Bool
    let content: () -> Content

    func makeUIViewController(
        context: Context
    ) -> PictureInPictureController<Content> {
        let uiViewController = PictureInPictureController(
            canStartAutomaticallyFromInline: canStartAutomaticallyFromInline,
            content: content()
        )
        let binding = $isPresented
        uiViewController.onStart = {
            if binding.wrappedValue != true {
                binding.wrappedValue = true
            }
        }
        uiViewController.onStop = {
            if binding.wrappedValue != false {
                binding.wrappedValue = false
            }
        }
        return uiViewController
    }

    func updateUIViewController(
        _ uiViewController: PictureInPictureController<Content>,
        context: Context
    ) {
        uiViewController.update(
            canStartAutomaticallyFromInline: canStartAutomaticallyFromInline,
            content: content()
        )

        if isPresented, !uiViewController.isActive {
            uiViewController.start()
        } else if !isPresented, uiViewController.isActive {
            uiViewController.stop()
        }
    }
}
