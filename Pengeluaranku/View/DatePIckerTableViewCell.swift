//
//  DatePIckerTableViewCell.swift
//  Pengeluaranku
//
//  Created by Hada on 07/02/21.
//

import UIKit

class DatePIckerTableViewCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let guide = self.layoutMarginsGuide
        
        self.datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.trailingAnchor.constraint(equalToSystemSpacingAfter: guide.trailingAnchor, multiplier: -3).isActive = true
        datePicker.centerYAnchor.constraint(equalToSystemSpacingBelow: self.centerYAnchor, multiplier: 1).isActive = true
        
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.maximumDate = Date()
        
        self.selectionStyle = .none
        self.backgroundColor = .systemBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
