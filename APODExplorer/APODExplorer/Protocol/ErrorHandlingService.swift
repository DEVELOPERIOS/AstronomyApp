//
//  ErrorHandlingService.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

protocol ErrorHandlingService {
    func showError(on viewController: UIViewController, message: String)
}
