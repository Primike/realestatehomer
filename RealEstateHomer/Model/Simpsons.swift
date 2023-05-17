//
//  Simpsons.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation

struct Simpsons: Decodable {
    let relatedTopics: [Simpson]

    enum CodingKeys: String, CodingKey {
        case relatedTopics = "RelatedTopics"
    }
}

struct Simpson: Decodable {
    let firstURL: String
    let icon: IconURL
    let text: String

    enum CodingKeys: String, CodingKey {
        case firstURL = "FirstURL"
        case icon = "Icon"
        case text = "Text"
    }
}

struct IconURL: Decodable {
    let url: String

    enum CodingKeys: String, CodingKey {
        case url = "URL"
    }
}
