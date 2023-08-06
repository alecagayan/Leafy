//
//  DiscoverView.swift
//  Leafy
//
//  Created by Alec Agayan on 8/6/23.
//

import SwiftUI

struct DiscoverView: View {
    @State private var recipes: [Recipe] = []
    @State private var searchText = "brisket"

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Discover")
                    .font(.custom("DMSans-Bold", size: 36))
                    .padding(.leading, 16)
                
                Spacer()
            }
            //horizontal scroll view with recipes from recipes array
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    List(recipes) { recipe in
                        NavigationLink(destination: RecipeView(recipe: recipe)) {
                            DiscoverLargeCard(recipe: recipe, onButtonTapped: {})
                        }
                    }
                }
            }
        }
    }
    
    func getRecipes() {
        FireStoreController().fetchRecipesByName(name: "Brisket") { fetchedRecipes in
            DispatchQueue.main.async {
                self.recipes = fetchedRecipes
            }
            print(fetchedRecipes)
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
