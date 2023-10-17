//
//  HomeModel.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/16/23.
//

import Foundation

struct HomeModel : Codable {
    let count : Int?
    let filters : Filters?
    let competition : Competition?
    let matches : [Matches]?
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case filters = "filters"
        case competition = "competition"
        case matches = "matches"
    }
}
struct Filters : Codable {
    let matchday : String?
    enum CodingKeys: String, CodingKey {
        case matchday = "matchday"
    }
}
struct Competition : Codable {
    let id : Int?
    let area : Area?
    let name : String?
    let code : String?
    let plan : String?
    let lastUpdated : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case area = "area"
        case name = "name"
        case code = "code"
        case plan = "plan"
        case lastUpdated = "lastUpdated"
    }
}
struct Area : Codable {
    let id : Int?
    let name : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
struct Matches : Codable {
    let id : Int?
    let season : Season?
    let utcDate : String?
    let status : String?
    let matchday : Int?
    let stage : String?
    let group : String?
    let lastUpdated : String?
    let odds : Odds?
    let score : Score?
    let homeTeam : HomeTeam?
    let awayTeam : AwayTeam?
    let referees : [Referees]?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case season = "season"
        case utcDate = "utcDate"
        case status = "status"
        case matchday = "matchday"
        case stage = "stage"
        case group = "group"
        case lastUpdated = "lastUpdated"
        case odds = "odds"
        case score = "score"
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
        case referees = "referees"
    }
}
struct Score : Codable {
    let winner : String?
    let duration : String?
    let fullTime : FullTime?
    let halfTime : HalfTime?
    let extraTime : ExtraTime?
    let penalties : Penalties?
    enum CodingKeys: String, CodingKey {
        case winner = "winner"
        case duration = "duration"
        case fullTime = "fullTime"
        case halfTime = "halfTime"
        case extraTime = "extraTime"
        case penalties = "penalties"
    }
}
struct Season : Codable {
    let id : Int?
    let startDate : String?
    let endDate : String?
    let currentMatchday : Int?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case startDate = "startDate"
        case endDate = "endDate"
        case currentMatchday = "currentMatchday"
    }
}
struct AwayTeam : Codable {
    let id : Int?
    let name : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
struct ExtraTime : Codable {
    let homeTeam : String?
    let awayTeam : String?
    enum CodingKeys: String, CodingKey {
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
    }
}
struct FullTime : Codable {
    let homeTeam : Int?
    let awayTeam : Int?
    enum CodingKeys: String, CodingKey {
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
    }
}
struct HalfTime : Codable {
    let homeTeam : Int?
    let awayTeam : Int?
    enum CodingKeys: String, CodingKey {
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
    }
}
struct Penalties : Codable {
    let homeTeam : String?
    let awayTeam : String?
    enum CodingKeys: String, CodingKey {
        case homeTeam = "homeTeam"
        case awayTeam = "awayTeam"
    }
}
struct Odds : Codable {
    let msg : String?
    enum CodingKeys: String, CodingKey {
        case msg = "msg"
    }
}
struct HomeTeam : Codable {
    let id : Int?
    let name : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
struct Referees : Codable {
    let id : Int?
    let name : String?
    let role : String?
    let nationality : String?
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case role = "role"
        case nationality = "nationality"
    }
}
struct DayModel : Codable {
    let date  : String?
    let matches : [Matches]?
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case matches = "matches"
    }
}
