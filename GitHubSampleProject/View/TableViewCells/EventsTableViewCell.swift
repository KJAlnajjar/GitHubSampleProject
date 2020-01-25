//
//  EventsTableViewCell.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/24/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit
import SDWebImage

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configure(model: MainEventsRealmModel) {
        self.repositoryImageView.sd_setImage(with: URL(string: model.actor?.avatarURL ?? ""), placeholderImage: UIImage(named: "placeholder"))
        self.typeLabel.text = model.type
        
        self.authorNameLabel.text = model.actor?.login ?? ""
        self.messageLabel.text = model.payload?.ref ?? ""
        self.dateLabel.text = Utilities.getFormattedDate(string: model.createdAt)
    }
}
