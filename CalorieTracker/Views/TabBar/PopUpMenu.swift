import SwiftUI

struct PopUpMenu: View {
    //So before we had @ObservedObject var router = ViewRouter() which wasn't working, so now we're passing a router into here
    @ObservedObject var router: ViewRouter
    
    //First layer of binding the showMenu so we can pass it into the MenuItem and change it from there
    @Binding var showMenu: Bool
        
    init(router: ViewRouter, showMenu: Binding<Bool>) {
        self.router = router
        self._showMenu = showMenu
    }

    var body: some View {
        HStack(spacing: 24) {
            Spacer()
            MenuItem(viewModel: .newFood, router: router, showMenu: $showMenu)
            MenuItem(viewModel: .newRecipe, router: router, showMenu: $showMenu)
            MenuItem(viewModel: .newMeal, router: router, showMenu: $showMenu)
            Spacer()
        }
        .transition(.scale)
        .background(
            RoundedRectangle(cornerRadius: 50, style: .continuous)
                .fill(.ultraThinMaterial)
                .environment(\.colorScheme, .dark)
                .frame(maxWidth: UIScreen.main.bounds.width / 1.5)
                .frame(height: 120)
                
        )
    }
}

struct MenuItem: View {
    let dimension: CGFloat = 48
    let viewModel: MenuViewModel
    
    @ObservedObject var router: ViewRouter
    
    //Second layer of binding the showMenu item so we can set it from here
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            Button {
                //Change the view
                router.currentItem = CurrentViewItem.menu(viewModel)
                withAnimation {
                    showMenu = false
                }
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color(.white))
                        .frame(width: dimension, height: dimension)
                        .shadow(radius: 4)
                    
                    Image(systemName: viewModel.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(12)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }
                
                
            }
            .overlay {
                Text(viewModel.title)
                    .foregroundStyle(.white)
                    .font(.footnote)
                    .offset(y: -50)
                    .multilineTextAlignment(.center)
            }
        }
        .offset(y: 20)
        
    }
}

