import SwiftUI

extension View {
    var size: CGSize {
        let host = UIHostingController(rootView: self)
        return host.sizeThatFits(in: .infinity)
    }
}
