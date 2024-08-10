//
//  URLSessionImageLoadingService.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

class URLSessionImageLoadingService: ImageLoadingService {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil)
                }
                print("Failed to load image: \(error.localizedDescription)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}
