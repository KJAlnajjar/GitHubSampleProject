//
//  RepositoriesViewController.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/23/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    var userRepositories = [UserRepositoriesModel]()
    var filterdUserRepositories = [UserRepositoriesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserRepositories()
    }
    
    private func getUserRepositories() {
        self.showActivityIndicator()
        GitHubAPIs.getUserRepositories(success: { userRepositories in
            self.userRepositories = userRepositories
            self.filterdUserRepositories = userRepositories
            self.reloadTableView()
            self.hideActivityIndicator()
        }) { error in
            print(error)
            self.hideActivityIndicator()
            self.showErrorMessageAlert()
        }
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdUserRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoriesCell", for: indexPath) as! RepositoriesTableViewCell
        
        if filterdUserRepositories.count != 0 {
            cell.configure(model: filterdUserRepositories[indexPath.row])
        } else {
            cell.configure(model: userRepositories[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}

extension RepositoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterdUserRepositories = searchText.isEmpty ? userRepositories : userRepositories.filter { $0.name.contains(searchText) }
        self.reloadTableView()
    }
}
