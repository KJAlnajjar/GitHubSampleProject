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
        self.getMainUserData()
    }
    
    private func getMainUserData() {
        GitHubAPIs.getMainUserData(success: { mainUserData in
            let data = Data(from: mainUserData.login)
            let _ = KeyChainService.save(key: "userName", data: data)
            self.getMainEvents(userName: mainUserData.login)
        }) { error in
            print(error)
            self.showAlert()
        }
    }
    
    private func getMainEvents(userName: String) {
        GitHubAPIs.getMainEvents(userName: userName, success: { mainEvents in
            print(mainEvents)
        }) { error in
            print(error)
            self.showAlert()
        }
    }
    
    private func showAlert() {
        DispatchQueue.main.async {
            self.showAlert(for: 2, title: "Sorry, Something went wrong", message: nil)
        }
    }
}

