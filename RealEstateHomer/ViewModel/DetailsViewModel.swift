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
        self.image = simpson.icon.url
        self.text = simpson.text
        self.name = "Name"
        self.url = simpson.firstURL
    }
}
