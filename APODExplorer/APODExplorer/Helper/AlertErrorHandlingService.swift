//
//  AlertErrorHandlingService.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

class AlertErrorHandlingService: ErrorHandlingService{
    func showError(on viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController.present(alert, animated: true, completion: nil)
    }
}
