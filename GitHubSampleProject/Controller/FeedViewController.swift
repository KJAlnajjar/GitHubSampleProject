//
//  FeedViewController.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/22/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit
import RealmSwift

class FeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var mainEvents = [MainEventsRealmModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handleTheDataSourcce()
    }
    
    private func handleTheDataSourcce() {
        if Utilities.isConnectedToNetwork() {
            self.getMainUserData()
        } else {
            self.mainEvents = Utilities.getLocalData()
            self.tableView.reloadData()
        }
    }
    
    private func getMainUserData() {
        GitHubAPIs.getMainUserData(success: { mainUserData in
            let data = Data(from: mainUserData.login)
            let _ = KeyChainService.save(key: "userName", data: data)
            self.getMainEvents(userName: mainUserData.login)
        }) { error in
            print(error)
            self.showErrorMessageAlert()
        }
    }
    
    private func getMainEvents(userName: String) {
        GitHubAPIs.getMainEvents(userName: userName, success: { mainEvents in
            print(mainEvents)
            self.mainEvents = mainEvents
            DispatchQueue.main.async {
                self.saveDataToRealm(mainEvents: mainEvents)
                self.tableView.reloadData()
            }
        }) { error in
            print(error)
            self.showErrorMessageAlert()
        }
    }
    
    private func saveDataToRealm(mainEvents: [MainEventsRealmModel]) {
        print(Thread.current)

        let model = MainHeaderEventsRealmModel()

        model.results.append(objectsIn: mainEvents)

        let realm = try! Realm()
        try! realm.write {
            print(Thread.current)

            realm.deleteAll()
            realm.add(model)
        }
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.mainEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventsCell", for: indexPath) as! EventsTableViewCell
        cell.configure(model: self.mainEvents[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }
}
