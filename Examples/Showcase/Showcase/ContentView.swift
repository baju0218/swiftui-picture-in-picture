import Combine
import PictureInPicture
import SwiftUI

struct ContentView: View {
    @State private var seconds = 0
    @State private var isPresented = false
    @State private var canStartAutomaticallyFromInline = false

    var body: some View {
        VStack {
            if #available(iOS 15.0, *) {
                PictureInPictureView(seconds: seconds)
                    .pictureInPicture(
                        isPresented: $isPresented,
                        canStartAutomaticallyFromInline: canStartAutomaticallyFromInline
                    ) {
                        PictureInPictureView(seconds: seconds)
                    }
            } else {
                PictureInPictureView(seconds: seconds)
            }

            Spacer()

            Toggle("Auto-Start in Background", isOn: $canStartAutomaticallyFromInline)

            Toggle("Show Picture in Picture", isOn: $isPresented)
            
            Spacer()
        }
        .padding()
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            seconds += 1
        }
    }
}

#Preview {
    ContentView()
}
