//
//  SimpsonsViewController.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation
import UIKit

class SimpsonsViewController: UIViewController, SimpsonsViewModelDelegate {
    
    private(set) var viewModel: SimpsonsViewModel
    
    init(viewModel: SimpsonsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        
        viewModel.fetchData()
    }
    
    func didUpdate() {
        print(viewModel.simpsons[0])
    }
}
