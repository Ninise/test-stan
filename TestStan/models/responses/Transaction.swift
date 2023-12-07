//
//  Transaction.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation

/*
   {
     "id": 0,
     "created_at": "now",
     "type": "income",
     "amount": 0
   }
 */

struct Transaction: Codable {
    
    enum TransactionType {
        case income, expense
        
        func getValue() -> String {
            switch self {
            case .income: return "income"
            case .expense: return "expense"
            }
        }
    }
    
    let id: Int64
    let created_at: Int64
    let type: String
    let amount: Int
    
}
