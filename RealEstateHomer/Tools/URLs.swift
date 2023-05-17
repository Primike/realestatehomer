//
//  URLs.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation

enum URLs: String {
    case simpsons
    
    var value: URL? {
        switch self {
        case .simpsons:
            return URL(string: "https://api.duckduckgo.com/?q=simpsons+characters&format=json")
        }
    }
}
