//
//  ShowViewModel.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation

protocol ShowViewModelDelegate: AnyObject {
    func didFinishFetch()
}

protocol ShowViewModeling {
    var personalities: [Personality] { get }
    var searchResults: [Personality] { get }
    var delegate: ShowViewModelDelegate? { get set }
    func fetchData()
    func getCellName(for indexPath: IndexPath) -> String
    func getPersonality(for indexPath: IndexPath) -> Personality?
    func getSearchResults(searchText: String)
}

class ShowViewModel: ShowViewModeling {
    
    private let dataManager: ShowDataManaging
    private(set) var personalities = [Personality]()
    private(set) var searchResults = [Personality]()
    weak var delegate: ShowViewModelDelegate?
    private let urlString: String
    
    init(dataManager: ShowDataManager, urlString: String) {
        self.dataManager = dataManager
        self.urlString = urlString
    }
    
    func fetchData() {
        guard let url = URL(string: urlString) else {
            print(CustomError.invalidURL)
            return
        }
        
        dataManager.getShowData(url: url) { [weak self] (result) in
            guard let self = self, let delegate = self.delegate else { return }
            
            switch result {
            case .success(let data):
                self.personalities = data.relatedTopics
                self.searchResults = data.relatedTopics
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                delegate.didFinishFetch()
            }
        }
    }
    
    func getCellName(for indexPath: IndexPath) -> String {
        let text = searchResults[indexPath.row].text
        let name = String(text.split(separator: "-")[0])
        
        return name
    }
    
    func getPersonality(for indexPath: IndexPath) -> Personality? {
        return searchResults[indexPath.row]
    }
    
    //MARK: Removes all non lowercase alphanumerical strings in searchText and text
    //Could change the model with a pre-filtered variable to make this more efficient
    func getSearchResults(searchText: String) {
        if searchText.isEmpty {
            searchResults = personalities
            return
        }
        
        let searchString = searchText.lowercased().filter {
            ("a"..."z" ~= $0) || ("0"..."9" ~= $0)
        }
        
        searchResults = personalities.filter({ personality in
            let newText = personality.text.lowercased().filter {
                ("a"..."z" ~= $0) || ("0"..."9" ~= $0)
            }
            
            return newText.contains(searchString)
        })
    }
}
