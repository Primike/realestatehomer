//
//  DetailsViewModel.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation
import UIKit

class DetailsViewModel {
    let image: String
    let name: String
    let text: String
    let url: String
    
    //MARK: JSON data format requires this data manipulation
    init(personality: Personality) {
        let text = personality.text.split(separator: " - ")

        self.image = "https://ddg.kuriko.moe\(personality.icon.url)"
        self.name = String(text[0])
        self.text = String(text[1])
        self.url = personality.firstURL
    }
}
