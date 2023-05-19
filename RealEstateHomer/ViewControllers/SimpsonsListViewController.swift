//
//  SimpsonsListViewController.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation
import UIKit

class SimpsonsListViewController: UIViewController, SimpsonsViewModelDelegate {
    
    private(set) var viewModel: SimpsonsViewModel
    weak var delegate: DetailsDelegate?
    
    init(viewModel: SimpsonsViewModel) {
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
        searchBar.placeholder = "Search Simpsons"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        viewModel.fetchData()
    }
    
    func didUpdate() {
        setup()
        layout()
    }
    
    private func setup() {
        view.backgroundColor = .white
        
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SimpsonsTableViewCell.self, forCellReuseIdentifier: SimpsonsTableViewCell.reuseID)
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

extension SimpsonsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.simpsons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let simpsonsCell = tableView.dequeueReusableCell(withIdentifier: SimpsonsTableViewCell.reuseID, for: indexPath) as? SimpsonsTableViewCell else {
            print("Unable to dequeue SimpsonsTableViewCell")
            
            return UITableViewCell()
        }
        
        simpsonsCell.configure(name: viewModel.getCellName(for: indexPath))
        return simpsonsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(view.bounds.height/15)
    }

}

extension SimpsonsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //passviewmodeldatafor simpson
        delegate?.didSelect()
    }
}

extension SimpsonsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
