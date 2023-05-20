//
//  Error.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/20/23.
//

import Foundation

enum CustomError: Error {
    case noData
    case cellReuse
    case invalidURL
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noData:
            return "Error: No Data Available"
        case .cellReuse:
            return "Error: Unable to dequeue PersonalityTableViewCell"
        case .invalidURL:
            return "Error: Invalid URL"
        }
    }
}
