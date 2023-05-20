//
//  ShowDataManager.swift
//  RealEstateHomer
//
//  Created by Prince Avecillas on 5/17/23.
//

import Foundation

protocol ShowDataManaging {
    func getShowData(url: URL, completion: @escaping (Result<ShowData, Error>) -> Void)
}

class ShowDataManager: ShowDataManaging {
    
    func getShowData(url: URL, completion: @escaping (Result<ShowData, Error>) -> Void) {
        fetchData(url: url, customError: .noData, completion: completion)
    }
    
    private func fetchData<T: Decodable>(url: URL?, customError: CustomError, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(customError))
            return
        }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, _ in
            guard let data = data else {
                completion(.failure(customError))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(T.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(customError))
            }
        }
        task.resume()
    }
}
