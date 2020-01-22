//
//  UIViewControllerExtensions.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/22/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(for duration: Int, title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(duration)){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
