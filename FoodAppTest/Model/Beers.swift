//
//  Beers.swift
//  FoodAppTest
//
//  Created by Никита Мошенцев on 16.10.2022.
//

import Foundation


struct Beer {
    let name: String
    let imageUrl: String
    let description: String
}

extension Beer: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
        case description
    }
}
