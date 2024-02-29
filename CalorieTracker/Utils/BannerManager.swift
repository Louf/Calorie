import SwiftUI

class BannerManager: ObservableObject {
    @Published var showBanner: Bool = false
    @Published var image: String = ""
    @Published var message: String = ""

    func displayBanner(image: String, message: String, for duration: TimeInterval = 3) {
        self.image = image
        self.message = message
        withAnimation {
            showBanner = true
        }
        
        //Set up so that after three seconds, it will be set to false
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            withAnimation(.linear(duration: 1.2)) {
                self.showBanner = false
            }
        }
    }
}
