//
//  source.swift
//  Pengeluaranku
//
//  Created by Hada on 02/02/21.
//

import Foundation

struct Source {
    
    static var menuToTabIdentifier = "goToTabBarController"
    static var transactionSheetIdentifier = "goToTransactionSheet"
    static var cellIdentifier = "trackCells"
    static var nibName = "TransactionTableViewCell"
    static var newTransCell = "newTransactionCell"
    
    func formatted(from number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .currency
      
        if let converted = formatter.string(from: number as NSNumber) {
            return converted
        } else {
            return "0"
        }
    }
}

