//
//  RecipeView.swift
//  Leafy
//
//  Created by Alec Agayan on 6/12/23.
//

import SwiftUI

struct RecipeView: View {
    let recipe: Recipe
    @StateObject private var imageLoader: ImageLoader
    @Environment(\.colorScheme) var colorScheme
    
    init(recipe: Recipe) {
        self.recipe = recipe
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: URL(string: recipe.heroImageURL ?? "")!))
    }

    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    VStack {
                        HStack {
                            Text(recipe.name)
                                .font(.custom("DMSans-Medium", size: 30))
                            Spacer()
                        }
                        
                        // Display recipe image
                        if ((recipe.heroImage) != nil) {
                            Image(uiImage: recipe.heroImage!)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                        } else {
                            Image("placeholderlight")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                        }
                        
                        
                        // Display ingredients
                        HStack {
                            Text("Ingredients")
                                .font(.custom("DMSans-Medium", size: 26))
                                .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                            Spacer()

                        }
                        
                        ForEach(recipe.ingredients.indices, id: \.self) { index in
                            HStack {
                                Text(recipe.ingredients[index].name)
                                Spacer()
                                Text(recipe.ingredients[index].quantity)
                                    .multilineTextAlignment(.trailing)
                            }
                            .font(.custom("DMSans-Medium", size: 18))
                        }
                        
                        // Display directions
                        HStack {
                            Text("Directions")
                                .font(.custom("DMSans-Medium", size: 26))
                                .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                            Spacer()

                        }
                        
                        HStack {
                            VStack {
                                ForEach(recipe.directions.indices, id: \.self) { index in
                                    VStack(alignment: .leading) {
                                        Text(recipe.directions[index].header)
                                            .font(.custom("DMSans-Medium", size: 18))
                                        Text(recipe.directions[index].body)
                                            .lineLimit(4)
                                            .font(.custom("DMSans-Regular", size: 18))
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}



struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(recipe: Recipe(id: UUID().uuidString, name: "Banana Pudding", ingredients: [Ingredient(id: UUID().uuidString, name: "Banana", quantity: "2", unit: "count")], directions: [DirectionSet(id: UUID().uuidString, header: "Step 1", body: "Mix thoroughly until pudding-like consistency is achieved")], time: 120, description: "", likes: 2, creationDate: 1000, heroImageURL: "https://natashaskitchen.com/wp-content/uploads/2022/08/Banana-Pudding-SQ.jpg"))
    }
}
