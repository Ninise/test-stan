//
//  Expense.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation

struct DailyTransactions: Identifiable {
    var day: String
    var amount: Int
    var id = UUID()
}
