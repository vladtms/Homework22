//
//  SharedAccountDetails.swift
//  Homework22
//
//  Created by TMS on 11.12.2021.
//

import Foundation

struct SharedAccountDetails: JSONable, Decodable {
    let name: String
    let imagePath: String?
    let goal: Money?
    init?(json: JSONDict) {
        guard let name = json.string(key: "name") else { return nil }
        self.name = name
        self.imagePath = json.string(key: "picture")
        self.goal = Money(json: json.dictionaryValue(key: "goal"))
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case imagePath = "picture"
        case goal
    }
}
