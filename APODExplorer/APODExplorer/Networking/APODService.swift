//
//  APODService.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

class APODService: APODServiceProtocol {
    private let apiKey = "izCH8NavSVeWfgDHFmGh3Ula1ToMwmX2cFvXLjkL"
    private let baseURL = "https://api.nasa.gov/planetary/apod"
    
    func fetchAPOD(completion: @escaping (Result<APOD, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?api_key=\(apiKey)") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let apod = try JSONDecoder().decode(APOD.self, from: data)
                completion(.success(apod))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
