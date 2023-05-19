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
    
    init(simpson: Simpson) {
        let text = simpson.text.split(separator: " - ")

        self.image = "https://ddg.kuriko.moe\(simpson.icon.url)"
        self.name = String(text[0])
        self.text = String(text[1])
        self.url = simpson.firstURL
        
        print(simpson)

    }
}
