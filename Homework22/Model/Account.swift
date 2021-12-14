//
//  Account.swift
//  Homework22
//
//  Created by TMS on 11.12.2021.
//

enum AccountCodingKeys: String, CodingKey {
    case id
    case type = "kind"
    case iban
    case balance
    case baseBalance
    case current
    case credit = "card"
    case shared
}

struct Account: JSONable, Decodable {
    let id: String
    let type: AccountType
    let iban: String
    let balance: Money
    let baseBalance: Money

    init?(json: JSONDict) {
        guard let id = json.string(key: "id"),
            let type = AccountType(json: json),
            let iban = json.string(key: "iban"),
            let balance = Money(json: json.dictionaryValue(key: "balance")) else { return nil }
        self.id = id
        self.type = type
        self.iban = iban
        self.balance = balance
        self.baseBalance = Money(json: json.dictionaryValue(key: "baseBalance")) ?? balance
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AccountCodingKeys.self)
        id = container.stringValue(for: .id)
        type = try AccountType(from: decoder)
        iban = container.stringValue(for: .iban)
        balance = try container.objectValue(for: .balance)
        baseBalance = container.object(for: .baseBalance) ?? balance
    }

}
