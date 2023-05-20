//
//  PersonalityTableViewCell.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation
import UIKit

class PersonalityTableViewCell: UITableViewCell {
    static let reuseID = "PersonalityCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    func configure(name: String) {
        label.text = name
        
        layout()
    }
    
    private func layout() {
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
    }
}
