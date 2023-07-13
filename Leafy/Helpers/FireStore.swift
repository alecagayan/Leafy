//
//  FireStore.swift
//  Leafy
//
//  Created by Alec Agayan on 6/6/23.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore


class FireStoreController {
    
    func uploadRecipe(recipe: Recipe) {
        // upload image to firebase storage and get url
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("images/\(recipe.id).jpg")
        
        let ingredientData = recipe.ingredients.map { ingredient in
            return [
                "id": ingredient.id,
                "name": ingredient.name,
                "quantity": ingredient.quantity,
                "unit": ingredient.unit
            ]
        }
        
        let directionData = recipe.directions.map { directionSet in
            return [
                "id": directionSet.id,
                "header": directionSet.header,
                "body": directionSet.body
            ]
        }
        
        if (recipe.heroImage != nil) {
            let uploadTask = imageRef.putData(recipe.heroImage!.jpegData(compressionQuality: 0.5)!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    print("error")
                    return
                }
                let size = metadata.size
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("error")
                        return
                    }

                    // upload recipe to firestore
                    let db = Firestore.firestore()
                    db.collection("recipes").document(recipe.id).setData([
                        "name": recipe.name,
                        "ingredients": ingredientData,
                        "directions": directionData,
                        "time": recipe.time,
                        "description": recipe.description,
                        "rating": recipe.likes,
                        "date": recipe.creationDate,
                        "heroImageURL": downloadURL.absoluteString
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                }
            }
        } else {
            // upload recipe to firestore
            let db = Firestore.firestore()
            db.collection("recipes").document(recipe.id).setData([
                "name": recipe.name,
                "ingredients": ingredientData,
                "directions": directionData,
                "time": recipe.time,
                "description": recipe.description,
                "rating": recipe.likes,
                "date": recipe.creationDate,
                "heroImageURL": recipe.heroImageURL
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
        
    }
    
    func getLatestRecipes(completion: @escaping ([Recipe]?, Error?) -> Void) {
        let db = Firestore.firestore()
        var recipes: [Recipe] = []

        let ref = db.collection("recipes").order(by: "date", descending: true).limit(to: 3)
        ref.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
                completion(nil, error)
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()

                    // Convert ingredients
                    let ingredientsData = data["ingredients"] as? [[String: Any]] ?? []
                    var ingredients: [Ingredient] = []
                    for ingredientData in ingredientsData {
                        if let id = ingredientData["id"] as? String,
                            let name = ingredientData["name"] as? String,
                            let quantity = ingredientData["quantity"] as? String,
                            let unit = ingredientData["unit"] as? String {
                            let ingredient = Ingredient(id: id, name: name, quantity: quantity, unit: unit)
                            ingredients.append(ingredient)
                        }
                    }

                    // Convert directions
                    let directionsData = data["directions"] as? [[String: Any]] ?? []
                    var directions: [DirectionSet] = []
                    for directionData in directionsData {
                        if let id = directionData["id"] as? String,
                            let header = directionData["header"] as? String,
                            let body = directionData["body"] as? String {
                            let direction = DirectionSet(id: id, header: header, body: body)
                            directions.append(direction)
                        }
                    }

                    let recipe = Recipe(
                        id: document.documentID,
                        name: data["name"] as? String ?? "",
                        ingredients: ingredients,
                        directions: directions,
                        time: data["time"] as? String ?? "--:--",
                        description: data["description"] as? String ?? "",
                        likes: data["rating"] as? Int ?? 0,
                        creationDate: data["date"] as? Double ?? 0,
                        heroImageURL: data["heroImageURL"] as? String ?? "",
                        heroImage: nil
                    )
                    recipes.append(recipe)
                }
                completion(recipes, nil)
            }
        }
    }
    
    func fetchRecipesByName(name: String, completion: @escaping ([Recipe]) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("recipes")
            .whereField("name", isGreaterThanOrEqualTo: name)
            .whereField("name", isLessThan: name + "z")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("Failed to fetch recipes: \(error?.localizedDescription ?? "")")
                    completion([])
                    return
                }
                
                let recipes = documents.compactMap { document -> Recipe? in
                    let data = document.data()
                    
                    // Convert ingredients
                    let ingredientsData = data["ingredients"] as? [[String: Any]] ?? []
                    var ingredients: [Ingredient] = []
                    for ingredientData in ingredientsData {
                        if let id = ingredientData["id"] as? String,
                           let name = ingredientData["name"] as? String,
                           let quantity = ingredientData["quantity"] as? String,
                           let unit = ingredientData["unit"] as? String {
                            let ingredient = Ingredient(id: id, name: name, quantity: quantity, unit: unit)
                            ingredients.append(ingredient)
                        }
                    }
                    
                    // Convert directions
                    let directionsData = data["directions"] as? [[String: Any]] ?? []
                    var directions: [DirectionSet] = []
                    for directionData in directionsData {
                        if let id = directionData["id"] as? String,
                           let header = directionData["header"] as? String,
                           let body = directionData["body"] as? String {
                                let direction = DirectionSet(id: id, header: header, body: body)
                                directions.append(direction)
                                print(direction)
                        }
                    }
                    
                    let recipe = Recipe(
                        id: document.documentID,
                        name: data["name"] as? String ?? "",
                        ingredients: ingredients,
                        directions: directions,
                        time: data["time"] as? String ?? "--:--",
                        description: data["description"] as? String ?? "",
                        likes: data["likes"] as? Int ?? 0,
                        creationDate: data["creationDate"] as? Double ?? 0,
                        heroImageURL: data["heroImageURL"] as? String ?? "",
                        heroImage: nil
                    )
                    
                    return recipe
                }
                
                completion(recipes)
            }
    }
}

