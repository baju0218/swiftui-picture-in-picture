import SwiftUI

struct PlaceholderView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
            VStack {
                Image(systemName: "pip.fill")
                    .font(.system(size: 48))
                    .foregroundColor(.gray)
                Text("Playing in Picture in Picture")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .aspectRatio(16 / 9, contentMode: .fit)
    }
}

#Preview {
    PlaceholderView()
}
