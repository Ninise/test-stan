//
//  TransactionUtils.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation

class TransactionUtils {
  
    class func calculateDailyTransactions(transactions: [Transaction]) -> [DailyTransactions] {
        var transactionsByDay: [String: Int] = [:]

        for transaction in transactions {
            let createdDate = DateUtils.timestampToDate(transaction.created_at)
            let day = DateUtils.formatDateMMMd(createdDate)

            transactionsByDay[day, default: 0] += transaction.amount
        }
        
        
        return transactionsByDay.map {
            DailyTransactions(day: $0.key, amount: $0.value)
        }.sorted(by: {
            return DateUtils.stringToDate($0.day) < DateUtils.stringToDate($01.day)
        })
    }
    
    class func calculateDailyBalance(income: [DailyTransactions], expenses: [DailyTransactions]) -> [DailyTransactions] {
        var combinedDictionary: [String: Int] = [:]

        let expText = expenses.map({ DailyTransactions(day: $0.day, amount: $0.amount * -1) })
        for transaction in income + expText {
            combinedDictionary[transaction.day, default: 0] += transaction.amount
        }
        
        return combinedDictionary
            .map { DailyTransactions(day: $0.key, amount: $0.value) }
            .sorted(by: {
                return DateUtils.stringToDate($0.day) < DateUtils.stringToDate($01.day)
            })
    }
    
}
