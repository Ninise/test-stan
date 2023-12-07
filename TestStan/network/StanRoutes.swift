//
//  StanRoutes.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation

extension StanApi {
    class func createTransaction(request: NewTransaction, completion: @escaping (Result<Transaction, SError>) -> Void) {
        provider.request(.createTransaction(request: request), completion: { result in
            completion(objectData(of: result))
        })
    }
    
    class func removeTransaction(id: Int64, completion: @escaping (Result<Bool, SError>) -> Void) {
        provider.request(.removeTransaction(id), completion: { result in
            completion(objectData(of: result))
        })
    }
    
    class func getTransactions(completion: @escaping (Result<[Transaction], SError>) -> Void) {
        provider.request(.getTransactions, completion: { result in
            completion(objectData(of: result))
        })
    }
}
