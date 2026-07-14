# swiftui-picture-in-picture

Picture in Picture for SwiftUI — GPU-rendered, with working animations.

## Why

Most SwiftUI PiP libraries snapshot the view every frame into `AVSampleBufferDisplayLayer`. That's CPU-heavy (device gets hot) and breaks SwiftUI animations.

This library hosts the SwiftUI view directly inside `AVPictureInPictureVideoCallViewController`, so:

- **GPU-composited** by CoreAnimation — no per-frame snapshotting, no heat.
- **SwiftUI animations just work** — they render natively.

## Usage

```swift
import PictureInPicture
import SwiftUI

struct ContentView: View {
    @State private var isPresented = false

    var body: some View {
        MainView()
            .pictureInPicture(isPresented: $isPresented) {
                PiPView()
            }
    }
}
```

## Installation

Swift Package Manager:

```swift
.package(url: "https://github.com/baju0218/swiftui-picture-in-picture", from: "1.0.0")
```

## Setup

1. **Background Modes** → enable *Audio, AirPlay, and Picture in Picture*.
2. Activate an `AVAudioSession` category that supports background playback at launch:
   ```swift
   try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback)
   try AVAudioSession.sharedInstance().setActive(true)
   ```
3. PiP is unavailable in the Simulator — gate on `AVPictureInPictureController.isPictureInPictureSupported()`.
