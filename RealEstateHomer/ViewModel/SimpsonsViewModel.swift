//
//  SimpsonsViewModel.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation

protocol SimpsonsViewModelDelegate: AnyObject {
    func didUpdate()
}

class SimpsonsViewModel {
    
    private let dataManager: SimpsonsDataManager
    private(set) var simpsons = [Simpson]()
    weak var delegate: SimpsonsViewModelDelegate?
    
    init(dataManager: SimpsonsDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchData() {
        dataManager.getSimpsons(url: URLs.simpsons.value) { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
            case .success(let data):
                self.simpsons = data.relatedTopics
            case .failure(let error):
                print(error.localizedDescription)
            }
            delegate.didUpdate()
        }
    }
}
