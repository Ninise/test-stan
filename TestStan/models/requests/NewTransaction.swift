//
//  NewTransaction.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation
/*
{
  "type": "income",
  "amount": 0
}
 */

struct NewTransaction: Codable {
    let type: String
    let amount: Int
}
