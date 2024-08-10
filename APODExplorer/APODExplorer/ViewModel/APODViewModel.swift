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
    private var hasSeenAPODToday: Bool = false
    
    init(apodService: APODServiceProtocol) {
        self.apodService = apodService
        self.hasSeenAPODToday = UserDefaults.standard.bool(forKey: "hasSeenAPODToday")
    }
    
    func loadAPOD(completion: @escaping () -> Void) {
        apodService.fetchAPOD { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let apod):
                    self?.apod = apod
                    self?.errorMessage = nil
                    self?.hasSeenAPODToday = true
                    UserDefaults.standard.set(true, forKey: "hasSeenAPODToday")
                case .failure(let error):
                    if self?.hasSeenAPODToday == true {
                        self?.errorMessage = "We are not connected to the internet, showing you the last image we have."
                    } else {
                        self?.errorMessage = "Failed to load image: \(error.localizedDescription)"
                    }
                }
                completion()
            }
        }
    }
}
