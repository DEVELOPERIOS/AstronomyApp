//
//  UserDefaultsAPODStorageService.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

class UserDefaultsAPODStorageService: APODStorageService {
    private let key = "lastAPOD"
    
    func loadLastAPOD() -> APOD? {
        let defaults = UserDefaults.standard
        if let savedAPOD = defaults.object(forKey: key) as? Data {
            return try? JSONDecoder().decode(APOD.self, from: savedAPOD)
        }
        return nil
    }
    
    func saveLastAPOD(_ apod: APOD) {
        let defaults = UserDefaults.standard
        if let encoded = try? JSONEncoder().encode(apod) {
            defaults.set(encoded, forKey: key)
        }
    }
}
