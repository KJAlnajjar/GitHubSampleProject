//
//  RepositoriesTableViewCell.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/23/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var adminPermissionImageView: UIImageView!
    @IBOutlet weak var pushPermissionImageView: UIImageView!
    @IBOutlet weak var pullPermissionImageView: UIImageView!

    func configure(model: UserRepositoriesModel) {
        self.repositoryImageView.sd_setImage(with: URL(string: model.owner.avatarURL), placeholderImage: UIImage(named: "placeholder"))
        self.nameLabel.text = model.name
        self.adminPermissionImageView.image = model.permissions.admin ? UIImage(named: "TrueLogo") : UIImage(named: "FalseLogo")
        self.pushPermissionImageView.image = model.permissions.push ? UIImage(named: "TrueLogo") : UIImage(named: "FalseLogo")
        self.pullPermissionImageView.image = model.permissions.pull ? UIImage(named: "TrueLogo") : UIImage(named: "FalseLogo")
    }
    
}
