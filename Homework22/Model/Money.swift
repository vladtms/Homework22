//
//  Money.swift
//  Homework22
//
//  Created by TMS on 11.12.2021.
//

import Foundation

struct Money: JSONable, Decodable {
    let currency: String
    let amount: Int

    init?(json: JSONDict) {
        guard let currency = json.string(key: "currency"),
            let amount = json.int(key: "amount") else { return nil }
        self.currency = currency
        self.amount = amount
    }

}
