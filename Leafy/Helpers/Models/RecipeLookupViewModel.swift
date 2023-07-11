//
//  RecipeLookupViewModel.swift
//  Leafy
//
//  Created by Alec Agayan on 6/8/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RecipeLookupViewModel: ObservableObject {
    @Published var queriedRecipies: [Recipe] = []
        
        func fetchRecipes(with keyword: String) {
        let db = Firestore.firestore()
        let lowercaseKeyword = keyword.lowercased()
        
        db.collection("recipes")
            .whereField("name", isGreaterThanOrEqualTo: lowercaseKeyword)
            .whereField("name", isLessThanOrEqualTo: lowercaseKeyword + "\u{f8ff}")
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching recipes: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else { return }

            }
    }
}
