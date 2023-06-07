//
//  Ingredient.swift
//  Leafy
//
//  Created by Alec Agayan on 6/6/23.
//

import Foundation

struct Ingredient: Identifiable, Hashable, Codable {
    var id: String
    var name: String
    var quantity: String
    var unit: String
}
