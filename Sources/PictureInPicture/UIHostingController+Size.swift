import SwiftUI

extension UIHostingController {
    var size: CGSize {
        sizeThatFits(in: UIView.layoutFittingExpandedSize)
    }
}
