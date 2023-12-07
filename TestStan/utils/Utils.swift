//
//  Utils.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation

class Utils {
  
    
    class func currencyFormatter(_ amount: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2

        if let formattedString = numberFormatter.string(from: NSNumber(value: amount)) {
            return formattedString
        } else {
            return "0"
        }
    }
}
