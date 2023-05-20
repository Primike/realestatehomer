//
//  DetailsViewController.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation
import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    
    let viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 30
        return stackView
    }()
    
    lazy var textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        let placeholder = UIImage(named: "default")
        
        if let url = URL(string: viewModel.image) {
            imageView.kf.setImage(with: url, placeholder: placeholder)
        } else {
            imageView.image = placeholder
        }
        

        return imageView
    }()

    lazy var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.name
        label.font = UIFont.italicSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    lazy var text: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.text
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        updateStackViewAxis(for: view.bounds.size)
    }
    
    //MARK: Called when screen changes orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.updateStackViewAxis(for: size)
        })
    }
    
    func updateStackViewAxis(for size: CGSize) {
        detailsStackView.axis = size.width > size.height ? .horizontal : .vertical
    }
    
    private func layout() {
        view.backgroundColor = .white
        view.addSubview(detailsStackView)
        
        detailsStackView.addArrangedSubview(imageView)
        detailsStackView.addArrangedSubview(textStackView)
        
        textStackView.addArrangedSubview(name)
        textStackView.addArrangedSubview(text)
        
        NSLayoutConstraint.activate([
            detailsStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            detailsStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            imageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
            imageView.heightAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.widthAnchor, multiplier: 1),

            name.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45),
            text.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.45),

        ])
    }
}
