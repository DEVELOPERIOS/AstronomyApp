//
//  ImageLoadingService.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

protocol ImageLoadingService {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}
