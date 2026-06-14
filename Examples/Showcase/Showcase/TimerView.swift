import Combine
import SwiftUI

struct TimerView: View {
    @State private var seconds = 0

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
                .padding()
        }
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            seconds += 1
        }
    }

    private var formatted: String {
        String(format: "%02d:%02d", seconds / 60, seconds % 60)
    }
}
