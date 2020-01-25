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
    
    @IBOutlet weak var LoginMessageLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var oauthswift: OAuth2Swift?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleLoginButtonTitle()
        
    }
    
    private func handleLoginButtonTitle() {
        
        if !Utilities.isConnectedToNetwork() && Utilities.isLocalDataBaseEmpty() {
            self.LoginMessageLabel.text = "There is no internet connection"
            self.LoginMessageLabel.isHidden = false
            self.loginButton.isEnabled = false
        } else if Utilities.isConnectedToNetwork() {
            self.loginButton.setTitle("Log in", for: .normal)
        } else {
            self.LoginMessageLabel.text = "There is no internet connection, want to keep going?"
            self.LoginMessageLabel.isHidden = false
            self.loginButton.setTitle("Go ahead!", for: .normal)
        }
    }
    
    @IBAction func didPressLoginButton() {
        
        if Utilities.isConnectedToNetwork() {
            self.showActivityIndicator()
            self.getOAuthGithubToken(["consumerId": "38bdac265be9e8815b26",
                                      "consumerSecret": "7d8f34e322a34f772fb54490a03f633bbac8ce14"])
        } else if !Utilities.isLocalDataBaseEmpty() {
            let storyBoard = UIStoryboard(name: "Main", bundle:nil)
            let FeedViewController = storyBoard.instantiateViewController(withIdentifier: "OfflineModeMainPage") as! FeedViewController
            FeedViewController.modalPresentationStyle = .fullScreen
            self.present(FeedViewController, animated: true, completion: nil)
        }
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
                    self.hideActivityIndicator()
                    self.showErrorMessageAlert()
                }
        }
    }
    
    private func saveTokenAndPresentTapBar(token: String) {
        let data = Data(from: token)
        let _ = KeyChainService.save(key: "gitHubToken", data: data)
        self.hideActivityIndicator()
        self.showTheTapBarViewController()
    }
    
    private func showTheTapBarViewController() {
        if let tabViewController = storyboard!.instantiateViewController(withIdentifier: "MainTabBarController") as? UITabBarController {
            tabViewController.modalPresentationStyle = .fullScreen
            present(tabViewController, animated: true)
        }
    }
}
