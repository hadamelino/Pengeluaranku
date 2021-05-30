//
//  TransactionTableViewCell.swift
//  Pengeluaranku
//
//  Created by Hada on 04/02/21.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transactionCount: UILabel!
    @IBOutlet weak var nameOfTransaction: UILabel!
    @IBOutlet weak var dateTransaction: UILabel!
    @IBOutlet weak var priceTransaction: UILabel!
    @IBOutlet weak var paymentTransaction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nameOfTransaction.sizeToFit()
        nameOfTransaction.adjustsFontSizeToFitWidth = false
        nameOfTransaction.numberOfLines = 0
    
        dateTransaction.sizeToFit()
        
        priceTransaction.sizeToFit()
        priceTransaction.adjustsFontSizeToFitWidth = false
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
