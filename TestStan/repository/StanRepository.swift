//
//  StanRepository.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation

struct StanRepository {
    static let shared = StanRepository()
    
    private init() {}
    
    func createTransaction(request: NewTransaction, completion: @escaping (Result<Transaction, SError>) -> Void) {
        // cache in local database
        StanApi.createTransaction(request: request, completion: completion)
    }
    
    func getTransactions(completion: @escaping (Result<[Transaction], SError>) -> Void) {
        // fetch local db and return in completion while request is in progress
        // as soon as we receive it pass in same completion
        StanApi.getTransactions(completion: completion)
    }
    
    func removeTransaction(id: Int64, completion: @escaping (Result<Bool, SError>) -> Void) {
        // remove from a local db
        StanApi.removeTransaction(id: id, completion: completion)
    }
}
