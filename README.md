# swiftui-picture-in-picture

Picture in Picture support for SwiftUI

```swift
import PictureInPicture
import SwiftUI

struct ContentView: View {
    @State private var isPiP = false

    var body: some View {
        VStack {
            MainView()
                .pictureInPicture(isPresented: $isPiP) {
                    PiPView()
                }

            Toggle("Show Picture in Picture", isOn: $isPiP)
        }
    }
}
```

## Getting Started

### Installation

Add the package via Swift Package Manager.

```swift
dependencies: [
    .package(url: "https://github.com/baju0218/swiftui-picture-in-picture", from: "0.1.0"),
],
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "PictureInPicture", package: "swiftui-picture-in-picture"),
        ]
    ),
]
```

### Configuration

A few things to keep in mind when integrating the library.

1. **Enable Background Mode** — In **Signing & Capabilities**, add **Background Modes** and check **Audio, AirPlay, and Picture in Picture**.

2. **Configure `AVAudioSession`** — Activate a category that supports background playback (`.playback` or `.playAndRecord`) at app startup. `.ambient` and `.soloAmbient` will prevent it from starting.

   ```swift
   try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
   try AVAudioSession.sharedInstance().setActive(true)
   ```

3. **Check device support** — Gate PiP UI with `AVPictureInPictureController.isPictureInPictureSupported()`. Not available in the iOS Simulator.
