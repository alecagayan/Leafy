//
//  NewRecipeView.swift
//  Leafy
//
//  Created by Alec Agayan on 6/5/23.
//

import SwiftUI

struct NewRecipeView: View {
    @State var name: String = ""
    @State var shouldShowImagePicker = false
    @State var ingredients: Array<Ingredient> = []
    @State var directions: Array<DirectionSet> = []
    @Binding var presentPopup: Bool
    @State var image = UIImage()
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {

            ScrollView {
                HStack {
                    VStack {
                        HStack {
                            TextField("Recipe Name", text: $name)
                                .font(.custom("DMSans-Medium", size: 30))
                            Spacer()
                            //popup close button
                            Button(action: {
                                // close popup
                                presentPopup = false
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // large rectangular image that allows user to upload an image
                        Button(action: {
                            // upload image
                            shouldShowImagePicker.toggle()
                        }) {
                            //if image not selected yet, show placeholderlight image, otherwise show image
                            if image == UIImage() {
                                Image("placeholderlight")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                            } else {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                            }
                            
                        }
                        // interface for adding ingredients
                        // frame width 300x80 (width x height)
                        HStack {
                            Text("Ingredients")
                                .font(.custom("DMSans-Medium", size: 26))
                                .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                            Spacer()
                            Button(action: {
                                // create new ingredient entry row
                                ingredients.append(Ingredient(id: UUID().uuidString, name: "", quantity: "", unit: ""))
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        
                        // list of ingredients
                        // frame width 300x80 (width x height)
                        
                        ForEach(ingredients.indices, id: \.self) { index in
                            
                            HStack {
                                TextField("Ingredient Name", text: $ingredients[index].name)
                                Spacer()
                                TextField("Quantity", text: $ingredients[index].quantity)
                                    .multilineTextAlignment(.trailing)
                                
                                
                                
                            }
                            .font(.custom("DMSans-Medium", size: 18))
                            .foregroundColor(colorScheme == .dark ? .white : Color(red: 13/255, green: 35/255, blue: 41/255))
                        }
                        
                        HStack {
                            Text("Directions")
                                .font(.custom("DMSans-Medium", size: 26))
                                .foregroundColor(colorScheme == .dark ? Color(red: 209/255, green: 255/255, blue: 93/255) : Color(red: 13/255, green: 35/255, blue: 41/255))
                            Spacer()
                            Button(action: {
                                // create new ingredient entry row
                                directions.append(DirectionSet(id: UUID().uuidString, header: "", body: ""))
                                
                                
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                        HStack {
                            VStack {
                                ForEach(directions.indices, id: \.self) { index in
                                    
                                    VStack(alignment: .leading) {
                                        TextField("Header", text: $directions[index].header)
                                            .font(.custom("DMSans-Medium", size: 18))
                                        
                                        TextField("Body Text", text: $directions[index].body, axis: .vertical)
                                            .lineLimit(1...4)
                                            .font(.custom("DMSans-Regular", size: 18))
                                        
                                        
                                    }
                                    .foregroundColor(colorScheme == .dark ? .white : Color(red: 13/255, green: 35/255, blue: 41/255))
                                }
                            }
                            Spacer()
                        }
                    }
                    .padding(16)
                    .sheet(isPresented: $shouldShowImagePicker) {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                    }
                }
            }
            Spacer ()
            Button("Save") {
                // save recipe into Recipe struct
                let newRecipe = Recipe(id: UUID().uuidString, name: name, ingredients: ingredients, directions: directions, time: 1, description: "shrick", likes: 5, creationDate: Date().timeIntervalSince1970)
                
                //print newrecipe
                print(newRecipe)
                print("here i am")
                
                //save to firestore
                FireStoreController().uploadRecipe(recipe: newRecipe)
                    presentPopup = false
                
            }
            .buttonStyle(NextButton())
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView(presentPopup: .constant(false))
    }
}
