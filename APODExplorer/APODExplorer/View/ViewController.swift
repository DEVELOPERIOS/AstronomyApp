//
//  ViewController.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var explanationLabel: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private let viewModel: APODViewModel
    private let storageService: APODStorageService
    private let imageLoadingService: ImageLoadingService
    private let errorHandlingService: ErrorHandlingService
    
    init(viewModel: APODViewModel, storageService: APODStorageService,
         imageLoadingService: ImageLoadingService,
         errorHandlingService: ErrorHandlingService) {
        self.viewModel = viewModel
        self.storageService = storageService
        self.imageLoadingService = imageLoadingService
        self.errorHandlingService = errorHandlingService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let defaultService = APODService()
        let defaultStorageService = UserDefaultsAPODStorageService()
        let defaultImageLoadingService = URLSessionImageLoadingService()
        let defaultErrorHandlingService = AlertErrorHandlingService()
        self.viewModel = APODViewModel(apodService: defaultService)
        self.storageService = defaultStorageService
        self.imageLoadingService = defaultImageLoadingService
        self.errorHandlingService = defaultErrorHandlingService
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "APOD"
        loadAPOD()
    }
    
    private func loadAPOD() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        viewModel.loadAPOD { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.isHidden = true
            if let apod = self?.viewModel.apod {
                print("Data", apod.title!)
                self?.titleLabel.text = apod.title
                self?.explanationLabel.text = apod.explanation
                if let imageUrl = URL(string: apod.url) {
                    self?.imageLoadingService.loadImage(from: imageUrl) { [weak self] image in
                        self?.imageView.image = image
                        self?.storageService.saveLastAPOD(apod)
                    }
                }
            } else if let errorMessage = self?.viewModel.errorMessage {
                self?.errorHandlingService.showError(on: self!, message: errorMessage)
                if let lastAPOD = self?.storageService.loadLastAPOD() {
                    self?.titleLabel.text = lastAPOD.title
                    self?.explanationLabel.text = lastAPOD.explanation
                    if let imageUrl = URL(string: lastAPOD.url) {
                        self?.imageLoadingService.loadImage(from: imageUrl) { [weak self] image in
                            self?.imageView.image = image
                        }
                    }
                }
            } else {
                self?.errorHandlingService.showError(on: self!, message: "No data available.")
            }
        }
    }
}

