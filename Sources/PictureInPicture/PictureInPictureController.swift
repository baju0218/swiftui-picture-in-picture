import AVKit
import OSLog
import SwiftUI

@available(iOS 15.0, *)
final class PictureInPictureController<Content: View>:
    UIViewController,
    AVPictureInPictureControllerDelegate
{
    private static var logger: Logger {
        Logger(subsystem: "PictureInPicture", category: "PictureInPictureController")
    }

    // Picture in Picture
    private var controller: AVPictureInPictureController?
    private var canStartAutomaticallyFromInline: Bool

    // View
    private let hostingController: UIHostingController<Content>
    private let contentViewController = AVPictureInPictureVideoCallViewController()

    var onStart: (() -> Void)?
    var onStop: (() -> Void)?

    var isActive: Bool {
        controller?.isPictureInPictureActive ?? false
    }

    init(canStartAutomaticallyFromInline: Bool, content: Content) {
        self.canStartAutomaticallyFromInline = canStartAutomaticallyFromInline
        self.hostingController = UIHostingController(rootView: content)
        self.contentViewController.preferredContentSize = hostingController.size
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        setup()
    }

    func update(canStartAutomaticallyFromInline: Bool, content: Content) {
        self.controller?.canStartPictureInPictureAutomaticallyFromInline =
            canStartAutomaticallyFromInline
        self.canStartAutomaticallyFromInline = canStartAutomaticallyFromInline
        self.hostingController.rootView = content
        self.contentViewController.preferredContentSize = hostingController.size
    }

    func start() {
        controller?.startPictureInPicture()
    }

    func stop() {
        controller?.stopPictureInPicture()
    }

    private func setup() {
        guard AVPictureInPictureController.isPictureInPictureSupported() else {
            Self.logger.error("Picture in Picture is not supported on this device")
            return
        }
        setupContentView()
        setupPictureInPicture()
    }

    private func setupContentView() {
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        contentViewController.addChild(hostingController)
        contentViewController.view.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(
                equalTo: contentViewController.view.topAnchor
            ),
            hostingController.view.bottomAnchor.constraint(
                equalTo: contentViewController.view.bottomAnchor
            ),
            hostingController.view.leadingAnchor.constraint(
                equalTo: contentViewController.view.leadingAnchor
            ),
            hostingController.view.trailingAnchor.constraint(
                equalTo: contentViewController.view.trailingAnchor
            ),
        ])
        hostingController.didMove(toParent: contentViewController)
    }

    private func setupPictureInPicture() {
        let contentSource = AVPictureInPictureController.ContentSource(
            activeVideoCallSourceView: view,
            contentViewController: contentViewController
        )
        controller = AVPictureInPictureController(contentSource: contentSource)
        controller?.canStartPictureInPictureAutomaticallyFromInline =
            canStartAutomaticallyFromInline
        controller?.delegate = self
    }

    // MARK: - AVPictureInPictureControllerDelegate

    func pictureInPictureControllerDidStartPictureInPicture(
        _ pictureInPictureController: AVPictureInPictureController
    ) {
        onStart?()
    }

    func pictureInPictureControllerDidStopPictureInPicture(
        _ pictureInPictureController: AVPictureInPictureController
    ) {
        onStop?()
    }

    func pictureInPictureController(
        _ pictureInPictureController: AVPictureInPictureController,
        failedToStartPictureInPictureWithError error: Error
    ) {
        Self.logger.error(
            "Failed to start Picture in Picture: \(error.localizedDescription, privacy: .public)"
        )
    }
}
