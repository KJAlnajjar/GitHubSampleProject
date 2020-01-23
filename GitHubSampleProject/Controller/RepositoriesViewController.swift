//
//  RepositoriesViewController.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/23/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        GitHubAPIs.getUserRepositories(success: { userRepositories in
            
        }) { error in
            print(error)
        }
    }
}
