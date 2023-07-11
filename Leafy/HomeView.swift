//
//  HomeView.swift
//  Leafy
//
//  Created by Alec Agayan on 6/7/23.
//

import SwiftUI

struct HomeView: View {
    @State private var selection = 2

    var body: some View {
        TabView(selection: $selection) {
            RecipeSearchView()
                .tabItem{
                    Label("Search", systemImage: "doc.text.magnifyingglass")
                }
            NewRecipeView(presentPopup: .constant(true))
                .tabItem {
                    Label("New Recipe", systemImage: "plus")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
