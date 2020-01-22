//
//  FeedViewController.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/22/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GitHubAPIs.getMainUserData(success: { mainUserData in
            print(mainUserData)
        }) { error in
            print(error)
            self.showAlert(for: 2, title: "Sorry, Something went wrong", message: nil)
        }
    }
    
}

