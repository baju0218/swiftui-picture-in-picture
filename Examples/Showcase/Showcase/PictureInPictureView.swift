import SwiftUI

struct PictureInPictureView: View {
    let seconds: Int

    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            Text(formatted)
                .font(.system(size: 64, weight: .bold, design: .monospaced))
                .foregroundColor(.white)
                .minimumScaleFactor(0.1)
                .padding()
        }
        .aspectRatio(16 / 9, contentMode: .fit)
    }

    private var formatted: String {
        String(format: "%02d:%02d", seconds / 60, seconds % 60)
    }
}
