//
//  TabMenu.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 1/31/24.
//

import SwiftUI

struct TabMenu: View {
    @ObservedObject var router: ViewRouter
    @State private var showMenu = false
        
    init(router: ViewRouter) {
        self.router = router
    }
    
    var body: some View {
        ZStack {
            HStack {
                TabIcon(viewModel: .home, router: router)
                
                TabMenuIcon(showMenu: $showMenu)
                    .onTapGesture {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }
                
                TabIcon(viewModel: .foodLibrary, router: router)
            }
            .frame(height: UIScreen.main.bounds.height / 14)
            .frame(maxWidth: UIScreen.main.bounds.width / 1.5)
            .background(
                RoundedRectangle(cornerRadius: 50, style: .continuous).fill(.ultraThinMaterial)
            )
            
            if showMenu {
                PopUpMenu(router: router, showMenu: $showMenu)
                    .offset(y: -100)
            }
        }
        
    }
}

struct TabMenuIcon: View {
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .shadow(radius: 4)
            
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(Color(.black))
                .rotationEffect(Angle(degrees: showMenu ? 45 : 0))
        }
    }
}

struct TabIcon: View {
    let viewModel: TabBarViewModel
    @ObservedObject var router: ViewRouter
    
    var body: some View {
        Button {
            router.currentItem = CurrentViewItem.tabBar(viewModel)
        } label: {
            Image(systemName: viewModel.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 20, height: 20)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
        }
    }
}
