//
//  DefaultDisclosureTableViewCell.swift
//  Pengeluaranku
//
//  Created by Hada on 08/02/21.
//

import UIKit

class DefaultDisclosureTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.accessoryType = .disclosureIndicator
        self.backgroundColor = .systemBackground
        self.textLabel?.font = UIFont.systemFont(ofSize: 16)
        self.textLabel?.textColor = .label
        self.textLabel?.sizeToFit()
        self.textLabel?.textAlignment = .left
        self.detailTextLabel?.textColor = .systemGray2
        self.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
