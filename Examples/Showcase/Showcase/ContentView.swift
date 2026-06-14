import PictureInPicture
import SwiftUI

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        VStack {
            timer

            Button(isPresented ? "Stop Picture in Picture" : "Start Picture in Picture") {
                isPresented.toggle()
            }
        }
        .padding()
    }

    @ViewBuilder
    private var timer: some View {
        if #available(iOS 15.0, *) {
            TimerView()
                .pictureInPicture(isPresented: $isPresented) {
                    TimerView()
                }
        } else {
            TimerView()
        }
    }
}

#Preview {
    ContentView()
}
