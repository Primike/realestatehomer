//
//  ShowData.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation

struct ShowData: Decodable {
    let relatedTopics: [Personality]

    enum CodingKeys: String, CodingKey {
        case relatedTopics = "RelatedTopics"
    }
}

struct Personality: Decodable {
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
