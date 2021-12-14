//
//  CardAccountDetails.swift
//  Homework22
//
//  Created by TMS on 11.12.2021.
//

struct CardAccountDetails: JSONable, Decodable {
    let maskedPan: String
    init?(json: JSONDict) {
        guard let pan = json.string(key: "maskedPan") else { return nil }
        maskedPan = pan
    }
}
