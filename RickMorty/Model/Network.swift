//
//  Network.swift
//  RickMorty
//
//  Created by Anton on 22.08.23.
//

import Foundation

class NetworkManager {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let data = data {
                    do {
                        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                        let characters = apiResponse.results
                        completion(.success(characters))
                        print(data)
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        } else {
            let error = NSError(domain: "Domain", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
        }
    }
}

