//
//  NewRecipeView.swift
//  Leafy
//
//  Created by Alec Agayan on 6/5/23.
//

import SwiftUI
import PhotosUI
import FirebaseStorage
import Combine


struct NewRecipeView: View {
    
    @State var name: String = ""
    @State var time: String = ""
    @State private var selection = "Select"

    @State var shouldShowImagePicker = false
    @State var ingredients: Array<Ingredient> = []
    @State var directions: Array<DirectionSet> = []
//    @Binding var presentPopup: Bool
    @State var selectedItem: [PhotosPickerItem] = []
    @State var image = UIImage()
    @State var data: Data?


    @State var url: String = ""
    @State var imageURL: String = ""
    
    
    let tools = ["Grill", "Oven", "Stove", "Microwave", "Other"]
    let difficulties = ["Easy", "Medium", "Hard"]

    
    @Environment(\.colorScheme) var colorScheme
    
    func uploadImage(image: UIImage, completion: @escaping (_ imageURL: String, _ success: Bool) -> Void) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/\(UUID().uuidString).jpg")
        
        let uploadTask = imageRef.putData(image.jpegData(compressionQuality: 0.5)!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                print("error")
                return
            }
            
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("error")
                    return
                }
                
                let imageURL = downloadURL.absoluteString
                print(imageURL)
                completion(imageURL, true) // Pass the imageURL to the completion closure
            }
        }
    }
    // format time as xx:xx
    private func formatTime() {
        // Remove any non-digit and non-colon characters from the time string
        var cleanedTime = time.replacingOccurrences(of: "[^0-9:]", with: "", options: .regularExpression)
        
        // Make sure the time string has at most 5 characters
        if cleanedTime.count > 5 {
            cleanedTime = String(cleanedTime.prefix(5))
        }
        
        // Insert colon at appropriate position (xx:xx format)
        if cleanedTime.count >= 3 {
            let index = cleanedTime.index(cleanedTime.startIndex, offsetBy: 2)
            if cleanedTime[index] != ":" {
                cleanedTime.insert(":", at: index)
            }
        }
        
        // Add leading zero if necessary
        if cleanedTime.count == 2 && cleanedTime.last == ":" {
            cleanedTime = "0" + cleanedTime
        }
        
        // Update the time string
        time = cleanedTime
    }
    


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
//                            Button(action: {
//                                // close popup
//                                presentPopup = false
//                            }) {
//                                Image(systemName: "xmark.circle.fill")
//                                    .resizable()
//                                    .frame(width: 25, height: 25)
//                                    .foregroundColor(.gray)
//                            }
                        }
                        
                        // large rectangular image that allows user to upload an image
                        PhotosPicker(selection: $selectedItem,
                                     matching: .images) {
                                //if image not selected yet, show placeholderlight image, otherwise show image
                            if let data = data, let image = UIImage(data: data) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                } else {
                                    Image("emptyuploadlight")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(10)
                                }
                        }.onChange(of: selectedItem) { newValue in
                            guard let item = selectedItem.first else {
                                return
                            }
                            item.loadTransferable(type: Data.self) { result in
                                switch result {
                                case .success(let data):
                                    if let data = data {
                                        self.data = data
                                    }
                                case .failure(let failure):
                                    print("Error: \(failure.localizedDescription)")
                                }
                            }
                        }
                        
                        Spacer()
                            HStack {
                                Image(systemName: "clock")
                                //text field that always formats in xx:xx format
                                TextField("00:00", text: $time)
                                    .onReceive(Just(time)) { _ in
                                        formatTime()
                                    }
                                    .font(.custom("DMSans-Medium", size: 18))
                                    .foregroundColor(colorScheme == .dark ? .white : Color(red: 13/255, green: 35/255, blue: 41/255))
                                
//                                Image(systemName: "dumbbell")
//                                Picker("Select a difficulty level", selection: $selection) {
//                                    ForEach(difficulties, id: \.self) {
//                                        Text($0)
//                                    }
//                                }
//                                .padding(.leading, -16.0)
//                                .pickerStyle(.menu)
//                                .font(.custom("DMSans-Medium", size: 18))
//                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 13/255, green: 35/255, blue: 41/255))
//                                .frame(width: 150)
                                
                                Spacer()
                                
                                Image(systemName: "dumbbell")
                                Picker("Select a difficulty level", selection: $selection) {
                                    ForEach(difficulties, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .padding(.leading, -16.0)
                                .pickerStyle(.menu)
                                .font(.custom("DMSans-Medium", size: 18))
                                .foregroundColor(colorScheme == .dark ? .white : Color(red: 13/255, green: 35/255, blue: 41/255))

                            

                            }.padding(.horizontal, 8)
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
                    .padding(8)
                }
            }
            Spacer ()
            Button("Save") {
                // save recipe into Recipe struct
                
                //if there is an image, save it to storage
                if image != UIImage() {
                    uploadImage(image: image) { (imageURL, success) -> Void in
                        if success {
                            let newRecipe = Recipe(id: UUID().uuidString, name: name, ingredients: ingredients, directions: directions, time: time, description: "shrick", likes: 5, creationDate: Date().timeIntervalSince1970, heroImageURL: imageURL)
                            
                                FireStoreController().uploadRecipe(recipe: newRecipe)

                        }
                    }
                } else {
                    let newRecipe = Recipe(id: UUID().uuidString, name: name, ingredients: ingredients, directions: directions, time: time, description: "shrick", likes: 5, creationDate: Date().timeIntervalSince1970, heroImageURL: imageURL)
                    
                    FireStoreController().uploadRecipe(recipe: newRecipe)

                }
            }
            .buttonStyle(NextButton())
        }
        .padding()
        
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
    }
}
