//
//  APODViewModel.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

class APODViewModel {
    private let apodService: APODServiceProtocol
    var apod: APOD?
    var errorMessage: String?
    
    init(apodService: APODServiceProtocol) {
        self.apodService = apodService
    }
    
    func loadAPOD(completion: @escaping () -> Void) {
        apodService.fetchAPOD { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let apod):
                    self?.apod = apod
                    self?.errorMessage = nil
                case .failure(let error):
                    self?.errorMessage = "Failed to load image: \(error.localizedDescription)"
                }
                completion()
            }
        }
    }
}
