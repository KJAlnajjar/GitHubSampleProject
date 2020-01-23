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
    var filterdRepositories = [UserRepositoriesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getUserRepositories()
    }
    
    private func getUserRepositories() {
        self.showActivityIndicator()
        GitHubAPIs.getUserRepositories(success: { userRepositories in
            self.userRepositories = userRepositories
            self.filterdRepositories = userRepositories
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
        return filterdRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoriesCell", for: indexPath)
        
        if filterdRepositories.count != 0 {
            cell.textLabel?.text = filterdRepositories[indexPath.row].name
        } else {
            cell.textLabel?.text = userRepositories[indexPath.row].name
        }
        return cell
    }
}

extension RepositoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterdRepositories = searchText.isEmpty ? userRepositories : userRepositories.filter { $0.name.contains(searchText) }
        self.reloadTableView()
    }
}
