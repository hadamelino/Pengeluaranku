//
//  AccessoryTableViewController.swift
//  Pengeluaranku
//
//  Created by Hada on 07/02/21.
//

import UIKit

class AccessoryTableViewController: UITableViewController {

    var choiceTable: [[String]] = [[]]
    var titleName: String = ""
    var isCategory: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = UIView(frame: .zero)
        tableView.tableFooterView = view
        tableView.backgroundColor = .secondarySystemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = UIColor(named: "navBarTint")
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return choiceTable.count
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: .zero)
        return footer
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choiceTable[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "choiceCell", for: indexPath)
        cell.textLabel?.text = choiceTable[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = navigationController?.viewControllers[0] as! TransactionSheetTableViewController
    
        let data = choiceTable[1][indexPath.row]
        
        if isCategory {
            destinationVC.category = data
        } else {
            destinationVC.payment = data
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    

}
