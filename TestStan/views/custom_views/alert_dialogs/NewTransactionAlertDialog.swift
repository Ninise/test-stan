//
//  NewTransactionAlertDialog.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import SwiftUI

struct NewTransactionAlertDialogView: View {
        
    // need a desing of a dropdown...
    @State private var typeFieldText: String = "Income"
    @State private var textFieldText: String = ""
    
    var submitAlert: ((String, Int) -> Void)
    var dismissAlert: (() -> Void)
   
    
    var body: some View {
     
        VStack(alignment: .center) {
        
            Text("Add Entry")
                .font(.custom(FontUtils.FONT_BOLD, size: 16))
                .foregroundColor(.chartAmountText)
                .padding(.top, 10)
            
            VStack (alignment: .leading) {
                
                Text("Type")
                    .font(.custom(FontUtils.FONT_BOLD, size: 12))
                    .foregroundColor(.chartAmountText)
                    .padding(.bottom, 1)
                
                HStack {
            
                    TextField("$ 0.00", text: $typeFieldText)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                        .foregroundColor(Color.chartText)
                        .keyboardType(.numberPad)
                        .disabled(true)
                        .accentColor(.chartText)
                        .padding(.all, 15)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.textFieldBack)
                )
            }
            
            VStack (alignment: .leading) {
                
                Text("Amount")
                    .font(.custom(FontUtils.FONT_BOLD, size: 12))
                    .foregroundColor(.chartAmountText)
                    .padding(.bottom, 1)
                
                HStack {
                    Text("$")
                        .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                        .foregroundColor(Color.chartAmountText)
                        .padding(.leading, 15)
                    
                    TextField("", text: $textFieldText)
                        .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                        .foregroundColor(Color.chartText)
                        .keyboardType(.numberPad)
                        .placeholder(when: textFieldText.isEmpty, placeholder: {
                            Text("0.00")
                                .font(.custom(FontUtils.FONT_REGULAR, size: 14))
                                .foregroundColor(Color.chartText)
                        })
                        .accentColor(.chartText)
                        .padding(.vertical, 15)
                        .padding(.trailing, 15)
                        .padding(.leading, 5)
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.textFieldBack)
                )
            }
           
                    
            AppDefaultButton(title: "Submit", textColor: .white, buttonColor: .mainPurple, callback: {
                if let amount = Int(textFieldText) {
                    hideKeyboard()
                    submitAlert(typeFieldText.lowercased(), amount)
                }
            })
            
            AppDefaultButton(title: "Never Mind", textColor: .mainPurple, buttonColor: .white, callback: {
                hideKeyboard()
                dismissAlert()
            })
            
        }
        .padding()
        .background(Color.white)
        .frame(minWidth: 0, maxWidth: .infinity)
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
        
    }
    
}

struct NewTransactionAlertDialogModifier: ViewModifier {
    @Binding var dialog: NewTransactionAlertDialog?
    
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainDialogView()
                }.animation(.spring(), value: dialog)
            )
            .onChange(of: dialog) { value in
                showAlertDialog()
            }
    }
    
    @ViewBuilder func mainDialogView() -> some View {
        if let dialog = dialog {
            
            ZStack {
                
                Color
                    .black
                    .opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                
                    NewTransactionAlertDialogView(
                        submitAlert: { type, amount in
                            dialog.dismissAlert(type, amount)
                            dismissAlert()
                        },
                        dismissAlert: {
                            dismissAlert()
                        }
                    )
                    
                    Spacer()
                }
                .transition(.move(edge: .bottom))
            }
            
        }
    }
    
    private func showAlertDialog() {
        guard let dialog = dialog else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if dialog.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissAlert()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + dialog.duration, execute: task)
        }
    }
    
    private func dismissAlert() {
        withAnimation {
            dialog = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

struct NewTransactionAlertDialog: Equatable {
    
    static func == (lhs: NewTransactionAlertDialog, rhs: NewTransactionAlertDialog) -> Bool {
        return true
    }
    
    let duration: Double = 500
    var dismissAlert: ((String, Int) -> Void)
    
}

extension View {
    func newTransactionAlertDialogView(dialog: Binding<NewTransactionAlertDialog?>) -> some View {
        self.modifier(NewTransactionAlertDialogModifier(dialog: dialog))
    }
}


