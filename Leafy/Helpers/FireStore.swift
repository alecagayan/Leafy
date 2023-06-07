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
                "name": directionSet.header,
                "directions": directionSet.body
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
                "heroImageURL": ""
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
        
    }
    
//    func getTenRecipes() -> [Recipe] {
//        let db = Firestore.firestore()
//        var recipes: [Recipe] = []
//
//        db.collection("recipes").limit(to: <#T##Int#>)
//
//    }
}

