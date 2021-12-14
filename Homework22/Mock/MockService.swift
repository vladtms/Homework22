//
//  MockService.swift
//  Homework22
//
//  Created by TMS on 11.12.2021.
//

import Foundation

typealias NetworkResult<T> = Result<T, APIError>

enum APIErrorType {
    case parsing
    case noConnection
}

class APIError: Error {
    let type: APIErrorType
    static var parsing = APIError(type: .parsing)
    
    init(type: APIErrorType) {
        self.type = type
    }
}

class MockService {
    
    func getDataFromJSON<T: JSONable>(modelType: T.Type, name: String) -> T? {
        guard
            let path = Bundle.main.path(forResource: name, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else { return nil }
        
            var jsonDict = jsonObject as? JSONDict
            if jsonDict == nil,
                let jsonArray = jsonObject as? [JSONDict] {
                jsonDict = ["data": jsonArray]
            }
        
            guard let json = jsonDict,
                let model = T(json: json) else { return nil }
        
        return model
    }
}
