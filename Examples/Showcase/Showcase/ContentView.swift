import AVKit
import Combine
import PictureInPicture
import SwiftUI

struct ContentView: View {
    // Picture in Picture
    @State private var isPresented = false
    @State private var canStartAutomaticallyFromInline = false

    // View
    @State private var seconds = 0
    @State private var alert = false

    var body: some View {
        VStack {
            Group {
                if isPresented {
                    PlaceholderView()
                } else {
                    TimerView(seconds: seconds)
                }
            }
            .pictureInPicture(
                isPresented: $isPresented,
                canStartAutomaticallyFromInline: canStartAutomaticallyFromInline
            ) {
                TimerView(seconds: seconds)
            }

            toggles

            Spacer()

            button
//                .disabled(AVPictureInPictureController.isPictureInPictureSupported() == false)
        }
        .padding()
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            seconds += 1
        }
        .alert("Picture in Picture Unavailable", isPresented: $alert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("This device does not support Picture in Picture.")
        }
    }

    private var toggles: some View {
        VStack {
            Toggle("Auto-Start in Background", isOn: $canStartAutomaticallyFromInline)
        }
    }

    private var button: some View {
        Button {
            guard AVPictureInPictureController.isPictureInPictureSupported()
            else {
                alert = true
                return
            }
            isPresented.toggle()
        } label: {
            Label(
                isPresented ? "Stop Picture in Picture" : "Start Picture in Picture",
                systemImage: isPresented ? "pip.exit" : "pip.enter"
            )
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}

#Preview {
    ContentView()
}
