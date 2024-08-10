//
//  APOD.swift
//  APODExplorer
//
//  Created by Admin on 09/08/24.
//

import UIKit

struct APOD: Codable {
    let date: String?
    let explanation: String?
    let hdurl: String?
    let media_type: String?
    let title: String?
    let url: String
}
