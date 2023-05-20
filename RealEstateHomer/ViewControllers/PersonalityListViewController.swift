//
//  PersonalityListViewControl.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation
import UIKit

class PersonalityListViewController: UIViewController, ShowViewModelDelegate {
    
    private(set) var viewModel: ShowViewModeling
    weak var coordinator: ShowCoordinator?
    
    init(viewModel: ShowViewModeling) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = searchBar
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self

        viewModel.fetchData()
    }
    
    func didFinishFetch() {
        setup()
        layout()
    }
    
    private func setup() {
        view.backgroundColor = .white
        navigationItem.title = "Character List"
        

        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(PersonalityTableViewCell.self, forCellReuseIdentifier: PersonalityTableViewCell.reuseID)
    }
    
    private func layout() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension PersonalityListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let personalityCell = tableView.dequeueReusableCell(withIdentifier: PersonalityTableViewCell.reuseID, for: indexPath) as? PersonalityTableViewCell else {
            print("Unable to dequeue PersonalityTableViewCell")
            
            return UITableViewCell()
        }
        
        personalityCell.configure(name: viewModel.getCellName(for: indexPath))
        return personalityCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(view.bounds.height/15)
    }

}

extension PersonalityListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let personality = viewModel.getPersonality(for: indexPath), let coordinator = coordinator else {
            return
        }
        
        coordinator.didSelectRow(personality: personality)
    }
}

extension PersonalityListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getSearchResults(searchText: searchText)
        
        tableView.reloadData()
    }
}
