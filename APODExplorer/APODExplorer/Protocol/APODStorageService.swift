//
//  APODStorageService.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

protocol APODStorageService {
    func loadLastAPOD() -> APOD?
    func saveLastAPOD(_ apod: APOD)
}

