//
//  ViewRouter.swift
//  CalorieTracker
//
//  Created by Louis Farmer on 1/30/24.
//

import SwiftUI

enum CurrentViewItem {
    case menu(MenuViewModel)
    case tabBar(TabBarViewModel)
}

class ViewRouter: ObservableObject {
    @Published var currentItem: CurrentViewItem = .tabBar(.home)
    
    var view: some View {
        switch currentItem {
        case .menu(let menuViewModel):
            return AnyView(menuViewModel.view)
        case .tabBar(let tabBarViewModel):
            return AnyView(tabBarViewModel.view)
        
        }
    }
}

enum TabBarViewModel: Int, CaseIterable {
    case home
    case foodLibrary
    
    var imageName: String {
        switch self {
        case .home: return "house.fill"
        case .foodLibrary: return "book.pages.fill"
        }
    }
    
    var view: some View {
        switch self {
        case .home:
            return AnyView(HomeScreenView())
        case.foodLibrary:
            return AnyView(FoodLibraryView())
        }
    }
}

enum MenuViewModel: Int, CaseIterable {
    case newFood
    case newRecipe
    case newMeal
    
    var imageName: String {
        switch self {
        case .newFood: return "carrot.fill"
        case .newRecipe: return "book.pages.fill"
        case .newMeal: return "fork.knife.circle.fill"
        }
    }
    
    var title: String {
        switch self {
        case .newFood: return "New Food"
        case .newRecipe: return "New Recipe"
        case .newMeal: return "New Meal"
        }
    }
    
    var view: some View {
        switch self {
        case .newFood:
            return AnyView(NewFoodView())
        case.newRecipe:
            return AnyView(NewRecipeView())
        case.newMeal:
            return AnyView(NewMealView())
        }
    }
}
