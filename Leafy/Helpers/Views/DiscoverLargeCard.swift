//
//  DiscoverLargeCard.swift
//  Leafy
//
//  Created by Alec Agayan on 6/10/23.
//
//
//  RecipeBoxView.swift
//  Leafy
//
//  Created by Alec Agayan on 6/10/23.
//

import SwiftUI
import Combine

struct DiscoverLargeCard: View {
    var recipe: Recipe
    var onButtonTapped: () -> Void

    @Environment(\.colorScheme) var colorScheme

    @StateObject private var imageLoader: ImageLoader
    
    init(recipe: Recipe, onButtonTapped: @escaping () -> Void) {
        self.recipe = recipe
        self.onButtonTapped = onButtonTapped
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: URL(string: recipe.heroImageURL ?? "")!))
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomLeading) {
                if let image = imageLoader.image {
                    GeometryReader { geometry in
                        let imageSize = CGSize(width: geometry.size.width, height: geometry.size.width)
                        let croppedImage = image.cropToSquare()?.resize(to: imageSize)
                        VStack {
                            Spacer()
                            Image(uiImage: croppedImage ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.width)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .alignmentGuide(.bottom) { _ in geometry.size.height * 0.125 }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    // Adjust blur radius as desired
                } else {
                    //use system image titled placeholder
                    let image = Image(colorScheme == .dark ? "placeholderdark" : "placeholderlight")
                        GeometryReader { geometry in
                            let imageSize = CGSize(width: geometry.size.width, height: geometry.size.width)
                            VStack {
                                Spacer()
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: geometry.size.width)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .alignmentGuide(.bottom) { _ in geometry.size.height * 0.125 }
                            }
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                }
                
            }
            .frame(height: 220)
            .cornerRadius(16, corners: [.topLeft, .topRight])
            HStack {
                VStack(alignment: .leading) {
                    Text(recipe.name)
                        .font(.custom("DMSans-Medium", size: 18))
                    Text("\(recipe.likes) Likes")
                        .font(.custom("DMSans-Regular", size: 16))
                }
                Spacer()
                // navigationlink with recipe and heroImage as imageloader.image
                NavigationLink(destination: RecipeView(recipe: Recipe(id: recipe.id, name: recipe.name, ingredients: recipe.ingredients, directions: recipe.directions, time: recipe.time, description: recipe.description, likes: recipe.likes, creationDate: recipe.creationDate, heroImageURL: recipe.heroImageURL, heroImage: imageLoader.image))) {
                }

            }
        }
        
    }
}

struct DiscoverLargeCard_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverLargeCard(recipe: Recipe(id: UUID().uuidString, name: "Banana Pudding", ingredients: [Ingredient(id: UUID().uuidString, name: "Banana", quantity: "2", unit: "count")], directions: [DirectionSet(id: UUID().uuidString, header: "Step 1", body: "Mix thoroughly until pudding-like consistency is achieved")], time: "01:15", description: "", likes: 2, creationDate: 1000, heroImageURL: "https://natashaskitchen.com/wp-content/uploads/2022/08/Banana-Pudding-SQ.jpg"), onButtonTapped: {})
            .previewLayout(.sizeThatFits)
    }
}
