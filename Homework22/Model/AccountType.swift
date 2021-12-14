//
//  AccountType.swift
//  Homework22
//
//  Created by TMS on 11.12.2021.
//

enum AccountType: Decodable {
    case current
    case credit(CardAccountDetails)
    case shared(SharedAccountDetails)
    
    var typeString: AccountTypeString {
        switch self {
        case .current:
            return .current
        case .credit:
            return .credit
        case .shared:
            return .shared
        }
    }
    
    enum AccountTypeString: String, Decodable {
        case current = "CurrentAccount"
        case credit = "CardAccount"
        case shared = "SharedAccount"
    }
    
    init?(json: JSONDict) {
        guard let typeString = json.string(key: "kind"),
              let type = AccountTypeString(rawValue: typeString) else { return nil }
        switch type {
        case .current:
            self = .current
        case .credit:
            guard let cardJSON = json.dictionary(key: "card"),
                let details = CardAccountDetails(json: cardJSON) else { return nil }
            self = .credit(details)
        case .shared:
            guard let sharedJSON = json.dictionary(key: "shared"),
                let details = SharedAccountDetails(json: sharedJSON) else { return nil }
            self = .shared(details)
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AccountCodingKeys.self)
        let key = try container.decode(AccountTypeString.self, forKey: .type)
        switch key {
        case .current:
            self = .current
        case .credit:
            let details = try container.decode(CardAccountDetails.self, forKey: .credit)
            self = .credit(details)
        case .shared:
            let details = try container.decode(SharedAccountDetails.self, forKey: .shared)
            self = .shared(details)
        }
    }
}
