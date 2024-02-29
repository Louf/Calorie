import SwiftUI

struct BannerView: View {
    var image: String
    var message: String
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.headline)
            Spacer()
            Text(message)
                .font(.subheadline)
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
        .padding()
        .background(.ultraThinMaterial)
        .environment(\.colorScheme, .dark)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
}
