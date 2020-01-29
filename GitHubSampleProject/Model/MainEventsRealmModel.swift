//
//  MainEventsRealmModel.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/24/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import Foundation
import RealmSwift

class MainHeaderEventsRealmModel: Object, Codable {
    @objc dynamic var id = 0
    var results = List<MainEventsRealmModel>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

class MainEventsRealmModel: Object, Codable {
    @objc dynamic var id = ""
    @objc dynamic var type = ""
    @objc dynamic var actor: RealmActor!
    @objc dynamic var repo: RealmRepo!
    @objc dynamic var payload: RealmPayload!
    @objc dynamic var isPublic = false
    @objc dynamic var createdAt = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case actor = "actor"
        case repo = "repo"
        case payload = "payload"
        case isPublic = "public"
        case createdAt = "created_at"
    }
}

class RealmActor: Object, Codable {
    @objc dynamic var id = 0
    @objc dynamic var login = ""
    @objc dynamic var displayLogin = ""
    @objc dynamic var gravatarID = ""
    @objc dynamic var url = ""
    @objc dynamic var avatarURL = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case displayLogin = "display_login"
        case gravatarID = "gravatar_id"
        case url = "url"
        case avatarURL = "avatar_url"
    }
}

class RealmPayload: Object, Codable {
    
    @objc dynamic var ref: String? = ""
    @objc dynamic var head: String? = ""
    @objc dynamic var before: String? = ""
//    dynamic var commits = List<RealmCommit>()
    @objc dynamic var refType: String? = ""
    @objc dynamic var masterBranch: String? = ""
    @objc dynamic var payloadDescription: String? = ""
    @objc dynamic var pusherType: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case ref = "ref"
        case head = "head"
        case before = "before"
//        case commits = "commits"
        case refType = "ref_type"
        case masterBranch = "master_branch"
        case payloadDescription = "description"
        case pusherType = "pusher_type"
    }
}

class RealmCommit: Object, Codable {
    
    @objc dynamic var sha: String? = ""
    dynamic var author: AuthorRepo?
    @objc dynamic var message: String? = ""
//    @objc dynamic var distinct = false
    @objc dynamic var url: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case sha = "sha"
        case author = "author"
        case message = "message"
//        case distinct = "distinct"
        case url = "url"
    }
}

class AuthorRepo: Object, Codable {
    
    @objc dynamic var email = ""
    @objc dynamic var name = ""
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
        case name = "name"
    }
}

class RealmRepo: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case url = "url"
    }
}
