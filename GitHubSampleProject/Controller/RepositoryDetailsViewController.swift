//
//  RepositoryDetailsViewController.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/24/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryDetailsViewController: UIViewController {
    
    var repositoryData: UserRepositoriesModel!
    
    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var adminPermissionImageView: UIImageView!
    @IBOutlet weak var pushPermissionImageView: UIImageView!
    @IBOutlet weak var pullPermissionImageView: UIImageView!
    @IBOutlet weak var languageNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initElements()
    }
    
    func initElements() {
        self.repositoryImageView.sd_setImage(with: URL(string: repositoryData.owner.avatarURL), placeholderImage: UIImage(named: "placeholder"))
        self.nameLabel.text = "\(repositoryData.name) is a \(repositoryData.isPrivate ? "private" : "public") repository"
        self.adminPermissionImageView.image = repositoryData.permissions.admin ? UIImage(named: "TrueLogo") : UIImage(named: "FalseLogo")
        self.pushPermissionImageView.image = repositoryData.permissions.push ? UIImage(named: "TrueLogo") : UIImage(named: "FalseLogo")
        self.pullPermissionImageView.image = repositoryData.permissions.pull ? UIImage(named: "TrueLogo") : UIImage(named: "FalseLogo")
        self.languageNameLabel.text = repositoryData.language ?? "Not identified"
    }
}
