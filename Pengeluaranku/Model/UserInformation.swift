//
//  UserInformation.swift
//  Pengeluaranku
//
//  Created by Hada on 06/02/21.
//

import Foundation
import RealmSwift

class UserInformation: Object {
    
    @objc dynamic var pendapatan: Int = 0
    @objc dynamic var uang: Int = 0
    @objc dynamic var pengeluaran: Int = 0
    
}
