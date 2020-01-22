//
//  GitHubAPIs.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/21/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import Foundation

struct GitHubAPIs {
    
   static let mainGitHubAPI = "https://api.github.com"
    
    static func getMainUserData(success: @escaping (MainUserDataModel) -> (), failure: @escaping (Error) -> ()) {
        
        let accessToken = KeyChainService.load(key: "gitHubToken")!.to(type: String.self)        
        
        var request = URLRequest(url: URL(string: mainGitHubAPI + "/user")!)
        request.addValue("token \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(MainUserDataModel.self, from: data!)
                success(responseModel)
            } catch let error {
                print("JSON Serialization error")
                failure(error)
            }
        }).resume()
    }
    
}
