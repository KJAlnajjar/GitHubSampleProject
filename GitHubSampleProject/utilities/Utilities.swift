//
//  Utilities.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/24/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit

struct Utilities {
    
    static func showImageFromURL(url: String) -> UIImage {
        if let url = URL(string: url) {
            let data = try! Data(contentsOf: url)
            return UIImage(data: data)!
        }
        return UIImage()
    }
}
