//
//  ViewController.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

class ViewController: UIViewController {
    private let viewModel: APODViewModel
    
    init(viewModel: APODViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let defaultService = APODService()
        self.viewModel = APODViewModel(apodService: defaultService)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadAPOD()
    }
    
    private func loadAPOD() {
        viewModel.loadAPOD { [weak self] in
            if let apod = self?.viewModel.apod {
                print("Data", apod.title!)
            } else if let errorMessage = self?.viewModel.errorMessage {
                
            } else {
                // Handle no data available
            }
        }
    }
}

