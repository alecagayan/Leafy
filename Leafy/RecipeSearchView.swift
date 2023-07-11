import SwiftUI

struct RecipeSearchView: View {
    @State private var searchText = ""
    @State private var recipes: [Recipe] = []

    var body: some View {
        VStack {
            SearchBar(text: $searchText, onSearchButtonClicked: searchRecipes)

            List(recipes) { recipe in
                SearchResultRow(recipe: recipe, onButtonTapped: {})

            }
            .listStyle(PlainListStyle()) // Use plain list style to remove default list appearance
            //.padding(.top, 8) // Add top padding to the list

            Spacer()
        }
    }

    func searchRecipes() {
        FireStoreController().fetchRecipesByName(name: searchText) { fetchedRecipes in
            DispatchQueue.main.async {
                self.recipes = fetchedRecipes
            }
            print(fetchedRecipes)
        }
    }
}

struct RecipeSearchView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSearchView()
    }
}
