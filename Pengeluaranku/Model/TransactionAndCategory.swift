//
//  TransactionModel.swift
//  Pengeluaranku
//
//  Created by Hada on 04/02/21.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var categoryName: String = ""
    var transactions = List<Transaction>()
}

class Transaction: Object{
    
    @objc dynamic var transactionName: String = ""
    @objc dynamic var dateTransaction: Date = Date()
    @objc dynamic var priceTransaction: Int = 0
    @objc dynamic var paymentTransaction: String = ""
    @objc dynamic var noteTransaction: String = ""
    var parentCategory = LinkingObjects(fromType: Category.self, property: "transactions")

}
