import AVKit
import SwiftUI

@available(iOS 15.0, *)
final class PictureInPictureController<Content: View>:
    UIViewController,
    AVPictureInPictureControllerDelegate
{
    private let hostingController: UIHostingController<StretchView<Content>>
    private let contentViewController = AVPictureInPictureVideoCallViewController()
    private var pictureInPictureController: AVPictureInPictureController?

    var onStart: (() -> Void)?
    var onStop: (() -> Void)?

    var isActive: Bool {
        pictureInPictureController?.isPictureInPictureActive ?? false
    }

    init(content: Content) {
        self.hostingController = UIHostingController(
            rootView: StretchView(content: content)
        )
        super.init(nibName: nil, bundle: nil)
        contentViewController.preferredContentSize = content.size
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

    func update(content: Content) {
        hostingController.rootView = StretchView(content: content)
    }

    func start() {
        pictureInPictureController?.startPictureInPicture()
    }

    func stop() {
        pictureInPictureController?.stopPictureInPicture()
    }

    private func setup() {
        guard AVPictureInPictureController.isPictureInPictureSupported() else { return }
        setupContentView()
        setupPictureInPicture()
    }

    private func setupContentView() {
        contentViewController.addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
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
        let pictureInPictureController = AVPictureInPictureController(contentSource: contentSource)
        pictureInPictureController.delegate = self
        self.pictureInPictureController = pictureInPictureController
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
}
