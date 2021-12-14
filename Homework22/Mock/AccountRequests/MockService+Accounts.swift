//
//  MockService+Accounts.swift
//  Homework22
//
//  Created by TMS on 11.12.2021.
//

import Foundation

extension MockService {
    func getAccountList(completion: @escaping (NetworkResult<[Account]>) -> Void) {
        let timeout: Double = 0.5
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + timeout) {
            guard let list = self.getDataFromJSON(modelType: [Account].self, name: "accountList") else {
                completion(.failure(.parsing))
                return
            }
            completion(.success(list))
        }
    }
}
