//
//  MainEventsModel.swift
//  GitHubSampleProject
//
//  Created by Khaleel on 1/23/20.
//  Copyright © 2020 Khaleel. All rights reserved.
//

import Foundation

class MainEventsModel: Codable {
    let id: String
    let type: String
    let actor: Actor
    let repo: Repo
    let payload: Payload
    let welcomePublic: Bool
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case actor = "actor"
        case repo = "repo"
        case payload = "payload"
        case welcomePublic = "public"
        case createdAt = "created_at"
    }
}

// MARK: - Actor
struct Actor: Codable {
    let id: Int
    let login: String
    let displayLogin: String
    let gravatarID: String
    let url: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case login = "login"
        case displayLogin = "display_login"
        case gravatarID = "gravatar_id"
        case url = "url"
        case avatarURL = "avatar_url"
    }
}

// MARK: - Payload
struct Payload: Codable {
    let pushID: Int?
    let size: Int?
    let distinctSize: Int?
    let ref: String?
    let head: String?
    let before: String?
    let commits: [Commit]?
    let refType: String?
    let masterBranch: String?
    let payloadDescription: String?
    let pusherType: String?

    enum CodingKeys: String, CodingKey {
        case pushID = "push_id"
        case size = "size"
        case distinctSize = "distinct_size"
        case ref = "ref"
        case head = "head"
        case before = "before"
        case commits = "commits"
        case refType = "ref_type"
        case masterBranch = "master_branch"
        case payloadDescription = "c"
        case pusherType = "pusher_type"
    }
}

// MARK: - Commit
struct Commit: Codable {
    let sha: String
    let author: Author
    let message: String
    let distinct: Bool
    let url: String

    enum CodingKeys: String, CodingKey {
        case sha = "sha"
        case author = "author"
        case message = "message"
        case distinct = "distinct"
        case url = "url"
    }
}

// MARK: - Author
struct Author: Codable {
    let email: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case name = "name"
    }
}

// MARK: - Repo
struct Repo: Codable {
    let id: Int
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case url = "url"
    }
}
