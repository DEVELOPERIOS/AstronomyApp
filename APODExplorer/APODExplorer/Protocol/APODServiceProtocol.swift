//
//  APODServiceProtocol.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

protocol APODServiceProtocol {
    func fetchAPOD(completion: @escaping (Result<APOD, Error>) -> Void)
}
