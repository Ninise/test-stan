//
//  DashboardViewModel.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation
import SLogger

class DashboardViewModel: NSObject, ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var message: String? = nil
    
    @Published var startDate: String = "Sep 10, 2023"
    @Published var endDate: String = "Nov 10, 2023"
    
    
    @Published var totalBalance: Int = 0
    @Published var balance: [DailyTransactions] = []
    
    @Published var totalIncome: Int = 0
    @Published var income: [DailyTransactions] = []
    
    @Published var totalExpenses: Int = 0
    @Published var expenses: [DailyTransactions] = []
    
    func createTransaction(type: String, amount: Int) {
        self.isLoading = true
        StanRepository.shared.createTransaction(request: NewTransaction(type: type, amount: amount), completion: { result in
            switch result {
            case .success(_):
                Log.verbose("Transaction created")
            case .failure(let failure):
                self.message = failure.reason
            }
            
            self.isLoading = false
        })
        
    }
    
   
    func fetchTransactions() {
        self.isLoading = true
        
        StanRepository.shared.getTransactions(completion: { result in
            switch result {
            case .success(let transactions):
                
                
                // set the range for buttons
                if let first = transactions.first, let last = transactions.last {
                    self.startDate = DateUtils.formatDateMMMdyyyy(DateUtils.timestampToDate(first.created_at))
                    self.endDate = DateUtils.formatDateMMMdyyyy(DateUtils.timestampToDate(last.created_at))
                }
                
                // added filter simply to reduce the noize at the chart
                
                self.income = TransactionUtils.calculateDailyTransactions(transactions: transactions.filter { $0.type == Transaction.TransactionType.income.getValue()})
                    .filter { $0.amount > 0 }
                self.totalIncome = self.income.reduce(0) { $0 + $1.amount }
                
                self.expenses = TransactionUtils.calculateDailyTransactions(transactions: transactions.filter { $0.type == Transaction.TransactionType.expense.getValue()})
                    .filter { $0.amount > 0 }
                self.totalExpenses = self.expenses.reduce(0) { $0 + $1.amount }
                
                self.balance = TransactionUtils.calculateDailyBalance(income: self.income, expenses: self.expenses)
                    .filter { $0.amount > 50 || $0.amount < -50 }
                self.totalBalance = self.balance.reduce(0) { $0 + $1.amount }

                        
            case .failure(let failure):
                self.message = failure.reason
            }
            self.isLoading = false
        })
        
    }
    
    func removeTransaction(id: Int64) {
        self.isLoading = true
        
        StanRepository.shared.removeTransaction(id: id, completion: { result in
            switch result {
            case .success(_):
                // probably show a success alert/toast
                Log.verbose("Transaction removed")
            case .failure(let failure):
                self.message = failure.reason
            }
            
            self.isLoading = false
        })
        
    }
    
}
