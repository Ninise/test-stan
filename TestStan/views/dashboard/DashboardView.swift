//
//  DashboardView.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import SwiftUI
import Charts
import ShimmeringUiView

struct DashboardView: View {
    
    @StateObject var viewModel = DashboardViewModel()
    
    @State var startDate: String = "Sep 10, 2023"
    @State var endDate: String = "Nov 10, 2023"
    
    @State var newTransactionDialog: NewTransactionAlertDialog? = nil
    
    let plusSize: CGFloat = 24
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            
            Color.white.ignoresSafeArea()
            
            VStack (alignment: .leading) {
                
                Text("Dashboard")
                    .font(.custom(FontUtils.FONT_BOLD, size: 20))
                    .foregroundColor(.chartAmountText)
                    .padding(.top, 20)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 25)
                
                DateRangeSelectorView(
                    startDateAction: {
                        
                    }, 
                    endDateAction: {
                        
                    },
                    startDate: $startDate,
                    endDate: $endDate)
                .padding(.bottom, 20)
                .padding(.horizontal, 25)
                
                ScrollView (showsIndicators: false) {
                    VStack (alignment: .leading) {
                        
                        ChartView(
                            type: "Balance",
                            amount: viewModel.totalBalance,
                            transactions: viewModel.balance
                        )
                        .padding(.bottom, 20)
                        .padding(.horizontal, 25)
                        
                        ChartView(
                            type: "Income",
                            amount: viewModel.totalIncome,
                            transactions: viewModel.income
                        )
                        .padding(.bottom, 20)
                        .padding(.horizontal, 25)
                        
                        ChartView(
                            type: "Expenses",
                            amount: viewModel.totalExpenses,
                            transactions: viewModel.expenses
                        )
                        .padding(.bottom, 20)
                        .padding(.horizontal, 25)
                    }
                    
                }
                
                
            }
            .shimmering(active: viewModel.isLoading)

            
            FloatingButton {
                self.newTransactionDialog = NewTransactionAlertDialog(dismissAlert: { type, amount in
                    viewModel.createTransaction(type: type, amount: amount)
                })
            }

        }
        .onChange(of: viewModel.startDate, perform: { newValue in
            startDate = newValue
        })
        .onChange(of: viewModel.endDate, perform: { newValue in
            endDate = newValue
        })
        .newTransactionAlertDialogView(dialog: $newTransactionDialog)
        .onAppear {
            viewModel.fetchTransactions()
        }
    }
    
    
}

struct DateRangeSelectorView: View {
    
    let startDateAction: () -> Void
    let endDateAction: () -> Void
    
    @Binding var startDate: String
    @Binding var endDate: String
    
    let cornerSize: CGFloat = 8
    
    let arrowSize: CGFloat = 16
    
    var body: some View {
        HStack (alignment: .center) {
            
            Button(action: {
                startDateAction()
            }, label: {
                Text(startDate)
                    .font(.custom(FontUtils.FONT_MEDIUM, size: 12))
                    .foregroundColor(.dateRangeButtonText)
                    .padding()
                    .frame(maxWidth: .infinity)
            })
            .background(
                RoundedRectangle(cornerRadius: cornerSize)
                    .fill(Color.dateRangeButtonBack)
            )
            
            
            
            Image(systemName: "arrow.right")
                .resizable()
                .scaledToFit()
                .frame(width: arrowSize, height: arrowSize)
                .foregroundColor(.chartAmountText)
                .padding(.horizontal, 15)
            
            
            Button(action: {
                endDateAction()
            }, label: {
                Text(endDate)
                    .font(.custom(FontUtils.FONT_MEDIUM, size: 12))
                    .foregroundColor(.dateRangeButtonText)
                    .padding()
                    .frame(maxWidth: .infinity)
            })
            .background(
                RoundedRectangle(cornerRadius: cornerSize)
                    .fill(Color.dateRangeButtonBack)
            )
        }
    }
    
}

struct ChartView: View {
    
    let type: String
    let amount: Int
    let transactions : [DailyTransactions]
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(type)
                .font(.custom(FontUtils.FONT_REGULAR, size: 12))
                .foregroundColor(.chartText)
            
            Text("$\(Utils.currencyFormatter(amount))")
                .font(.custom(FontUtils.FONT_BOLD, size: 18))
                .foregroundColor(.chartAmountText)
                .padding(.top, 1)
                .padding(.bottom, 25)
            
            Chart(transactions) { trans in
                BarMark(
                    x: .value("Day", trans.day),
                    y: .value("Amount", trans.amount)
                )
                .cornerRadius(6)
                .foregroundStyle(chartBarColor())
            }
            .chartYAxis {
                AxisMarks(position: .leading) { value in
                    AxisGridLine(stroke: .init(lineWidth: 0.1)).foregroundStyle(Color.chartXYLabel)
                    AxisValueLabel() {
                        if let intValue = value.as(Int.self) {
                            Text("\(intValue)")
                                .font(.custom(FontUtils.FONT_REGULAR, size: 10))
                                .foregroundColor(.chartXYLabel)
                        }
                    }
                }
            }
            .chartXAxis {
                AxisMarks(position: .automatic, content: { value in
                    AxisValueLabel() {
                        if let day = value.as(String.self) {
                            Text(day)
                                .font(.custom(FontUtils.FONT_REGULAR, size: 10))
                                .foregroundColor(.chartXYLabel)
                        }
                    }
                })
            }
           
        }
        .padding(.all, 20)
        .background(.white)
        .cornerRadius(15)
        .shadow(color: Color(red: 0, green: 0.06, blue: 0.43).opacity(0.07), radius: 25, x: 0, y: 15)
    }
    
    func chartBarColor() -> Color {
        switch type {
        case "Balance": return Color.chartBalanceBar
        case "Income": return Color.chartIncomeBar
        case "Expenses": return Color.chartExpensesBar
        default:
            return Color.chartExpensesBar
        }
    }
    
}

#Preview {
    DashboardView()
}
