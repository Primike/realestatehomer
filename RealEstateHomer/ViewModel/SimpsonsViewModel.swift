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

protocol SimpsonsViewModeling {
    var simpsons: [Simpson] { get }
    var delegate: SimpsonsViewModelDelegate? { get set }
    func fetchData()
    func getCellName(for indexPath: IndexPath) -> String
    func getSimpson(for indexPath: IndexPath) -> Simpson?
}

class SimpsonsViewModel: SimpsonsViewModeling {
    
    private let dataManager: SimpsonsDataManaging
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
            
            DispatchQueue.main.async {
                delegate.didUpdate()
            }
        }
    }
    
    func getCellName(for indexPath: IndexPath) -> String {
        let text = simpsons[indexPath.row].text
        let name = String(text.split(separator: "-")[0])
        
        return name
    }
    
    func getSimpson(for indexPath: IndexPath) -> Simpson? {
        return simpsons[indexPath.row] 
    }
}
