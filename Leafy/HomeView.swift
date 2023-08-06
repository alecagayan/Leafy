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
            NewRecipeView()
                .tabItem {
                    Label("New Recipe", systemImage: "plus")
                }
                .tag(1)
            RecipeSearchView()
                .tabItem{
                    Label("Search", systemImage: "doc.text.magnifyingglass")
                }
                .tag(2)
                

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
