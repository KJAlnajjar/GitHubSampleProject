//
//  ViewController.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/20/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit
import OAuthSwift
import SafariServices

class LoginViewController: UIViewController {
    
    var oauthswift: OAuth2Swift?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didPressLoginButton() {
        self.getOAuthGithubToken(["consumerId": "38bdac265be9e8815b26",
                                  "consumerSecret": "7d8f34e322a34f772fb54490a03f633bbac8ce14"])
    }
    
    private func getOAuthGithubToken(_ serviceParameters: [String:String]){
        let oauthswift = OAuth2Swift(
            consumerKey:    serviceParameters["consumerId"]!,
            consumerSecret: serviceParameters["consumerSecret"]!,
            authorizeUrl:   "https://github.com/login/oauth/authorize",
            accessTokenUrl: "https://github.com/login/oauth/access_token",
            responseType:   "code"
        )
        
        oauthswift.authorizeURLHandler = OAuthSwiftOpenURLExternally.sharedInstance
        self.oauthswift = oauthswift
        
        let state = generateState(withLength: 20)
        let _ = oauthswift.authorize(
            withCallbackURL: URL(string: "GitHubSampleProject://oauth-callback/github")!,
            scope: "user,repo", state: state) { result in
                
                switch result {
                case .success(let (credential, _, _)):
                    print(credential.oauthToken)
                    self.saveTokenAndPresentTapBar(token: credential.oauthToken)
                case .failure(let error):
                    print(error.description)
                    self.showAlert(for: 2, title: "Sorry, Something went wrong", message: nil)
                }
        }
    }
    
    private func saveTokenAndPresentTapBar(token: String) {
        let data = Data(from: token)
        let _ = KeyChainService.save(key: "gitHubToken", data: data)
        self.showTheTapBarViewController()
    }
    
    private func showTheTapBarViewController() {
        if let tabViewController = storyboard!.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            tabViewController.modalPresentationStyle = .fullScreen
            present(tabViewController, animated: true)
        }
    }
}
