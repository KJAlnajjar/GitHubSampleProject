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
    
    func showErrorMessageAlert() {
        DispatchQueue.main.async {
            self.showAlert(for: 2, title: "Sorry, Something went wrong", message: nil)
        }
    }
    
    func showActivityIndicator() {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        
        backgroundView.addSubview(activityIndicator)
        
        self.view.addSubview(backgroundView)
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            if let background = self.view.viewWithTag(475647){
                background.removeFromSuperview()
            }
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func addEmptyMessageLabel() {
        let emptyMessageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        emptyMessageLabel.font = emptyMessageLabel.font.withSize(17)
        emptyMessageLabel.text = "There is no data available"
        self.view.addSubview(emptyMessageLabel)
        emptyMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyMessageLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        emptyMessageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
