import SwiftUI

struct ContentView: View {
    @ObservedObject var router = ViewRouter()
    
    @EnvironmentObject var bannerManager: BannerManager
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                //This is the white background on the back level, so that the content on each view can be kept inside the safe area
                Color.white
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    router.view
                               
                    Spacer()
                    
                    
                }
                
                //Banner manager setup, sees if the universal .showBanner bool has been set to true from anywhere in the app, if it has, show the banner
                //Also handles the showBanner = false if the user taps on the banner before it disappears
                //Had to explicitly define where the banner should be with a GeometryReader
                if bannerManager.showBanner {
                    BannerView(image: bannerManager.image, message: bannerManager.message)
                        .transition(.move(edge: .top))
                        .frame(width: geometry.size.width, height: 60) // Adjust height as needed
                        .position(x: geometry.size.width / 2, y: bannerManager.showBanner ? 30 : -30) // Adjust y position based on the banner's state
//                        .animation(.easeInOut(duration: 0.5))
                        .onTapGesture {
                            withAnimation {
                                bannerManager.showBanner = false
                            }
                        }
                        .zIndex(1)
                }
                
                
            }
            .overlay(alignment: .bottom) {
                TabMenu(router: router)
                    .padding(.bottom, 12)
            }
//            .preferredColorScheme(.dark)
        }
    }
}



#Preview {
    ContentView()
}


