//
//  TextFieldTableViewCell.swift
//  Pengeluaranku
//
//  Created by Hada on 07/02/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {

    
    @IBOutlet var cellTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        let guide = self.contentView.layoutMarginsGuide
        
        self.selectionStyle = .none
        
        self.cellTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.cellTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: guide.leadingAnchor, multiplier: 0).isActive = true
        self.cellTextField.trailingAnchor.constraint(equalToSystemSpacingAfter: guide.trailingAnchor, multiplier: 1).isActive = true
        
        
        self.cellTextField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.cellTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.cellTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.backgroundColor = .systemBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
