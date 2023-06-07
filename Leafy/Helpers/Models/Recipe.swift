//
//  Recipe.swift
//  Leafy
//
//  Created by Alec Agayan on 6/5/23.
//

import Foundation
import SwiftUI

struct Recipe: Identifiable, Codable {
    var id: String
    var name: String
    var ingredients: Array<Ingredient>
    var directions: Array<DirectionSet>
    var time: Int
    var description: String
    var likes: Double
    var creationDate: Double
    var heroImageURL: String?
    var heroImage: UIImage?

    private enum CodingKeys: String, CodingKey {
        case id, name, ingredients, directions, time, description, likes, creationDate, heroImageURL
    }

}


