//
//  EventsTableViewCell.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/24/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repositoryImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configure(model: MainEventsRealmModel) {
//        self.repositoryImageView.image = Utilities.showImageFromURL(url: model.actor?.avatarURL ?? "")
        self.typeLabel.text = model.type
        
        self.authorNameLabel.text = model.actor?.login ?? ""
        self.messageLabel.text = model.payload?.ref ?? ""
        self.dateLabel.text = model.createdAt
    }
}
