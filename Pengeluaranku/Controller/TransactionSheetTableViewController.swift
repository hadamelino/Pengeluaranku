//
//  TransactionSheetTableViewController.swift
//  Pengeluaranku
//
//  Created by Hada on 07/02/21.
//

import UIKit
import RealmSwift

class TransactionSheetTableViewController: UITableViewController {
    
    @IBOutlet weak var addButtonOutlet: UIBarButtonItem!
    
    let tableInformation = TableInformation()
    
    let realm = try! Realm()
    
    var categoryList: Results<Category> {
        return realm.objects(Category.self)
    }
    
    var category = ""
    var payment = ""
    var inputDate: Date?
    
    var selectedIndex: IndexPath?

    var inputNamaTextField = UITextField()
    var inputHargaTextField = UITextField()
    var inputNoteTextField = UITextField()
    
    var updateDelegate: UpdateDelegate?
    
    enum TextFieldData: Int {
        
        case titleTextField = 0
        case priceTextField = 1
        case noteTextField = 3
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
//        print(realm.configuration.fileURL)        
        addButtonOutlet.isEnabled = false
        tableView.rowHeight = 55
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorColor = .systemGray4
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedPath, animated: true)
            }
        tableView.reloadData()
        validateInput()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Save Data
        saveData()
        self.updateDelegate?.didUpdateData(self)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
 
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let header = UIView(frame: .zero)
        return header
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableInformation.information[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let information = tableInformation.information[indexPath.section][indexPath.row]
        
        let tfCell = tableView.dequeueReusableCell(withIdentifier: "newTransactionCell", for: indexPath) as! TextFieldTableViewCell
        
        tfCell.cellTextField.attributedPlaceholder = NSAttributedString.init(string: information, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray4])
        tfCell.cellTextField.tag = indexPath.row
        tfCell.cellTextField.delegate = self

        let dpCell = tableView.dequeueReusableCell(withIdentifier: "datePIckerCell", for: indexPath) as! DatePIckerTableViewCell
        dpCell.textLabel?.text = "Date"
        
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath) as! DefaultDisclosureTableViewCell
    
        if  indexPath.section == 1 {
            if indexPath.row == 0 {
                tfCell.cellTextField.text = inputNamaTextField.text
                tfCell.cellTextField.autocapitalizationType = .words
                return tfCell
            } else if indexPath.row == 1 {
                tfCell.cellTextField.text = inputHargaTextField.text
                tfCell.cellTextField.keyboardType = .numberPad
                return tfCell
            }  else if indexPath.row == 2 {
                defaultCell.textLabel?.text = information
                defaultCell.detailTextLabel?.text = category
                return defaultCell
            } else if indexPath.row == 3 {
                tfCell.cellTextField.text = inputNoteTextField.text
                tfCell.cellTextField.autocapitalizationType = .sentences
                return tfCell
            }
        }
        else if indexPath.section == 2 {
            if indexPath.row == 0 {
                dpCell.datePicker.addTarget(self, action: #selector(dateChanged(sender:)), for: .valueChanged)
                return dpCell
            } else if indexPath.row == 1 {
                defaultCell.textLabel?.text = information
                defaultCell.detailTextLabel?.text = payment
                return defaultCell
            }
        }
        return defaultCell
    }
    
    @objc func dateChanged(sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: sender.date)
        let date = Calendar.current.date(from: components)
        inputDate = date
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedIndex = indexPath
        performSegue(withIdentifier: "disclosureIndicator", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! AccessoryTableViewController

        if selectedIndex?.section == 1 && selectedIndex?.row == 2 {
            destinationVC.titleName = "Category"
            destinationVC.choiceTable.append(tableInformation.category)
            destinationVC.isCategory = true
        } else if selectedIndex?.section == 2 && selectedIndex?.row == 1 {
            destinationVC.titleName = "Payment"
            destinationVC.choiceTable.append(tableInformation.payment)
        }
       
    }
    
    
    //MARK: - Textfield Validation
    func validateInput() {
        let text1 = self.inputNamaTextField.text ?? ""
        let text2 = self.inputHargaTextField.text ?? ""
        
        if !text1.isEmpty && !text2.isEmpty && !category.isEmpty && !payment.isEmpty {
            addButtonOutlet.isEnabled = true
        } else {
            addButtonOutlet.isEnabled = false
        }
    }
    
    //MARK: - Save Data
    func saveData(){
                
        let newCategory = Category()
        let updatedInformation = realm.objects(UserInformation.self).first!
        
        let newTransaction = Transaction()
        
        newTransaction.transactionName = inputNamaTextField.text!
        newTransaction.priceTransaction = Int(inputHargaTextField.text!)!
        newTransaction.noteTransaction = inputNoteTextField.text!
        newTransaction.dateTransaction = inputDate ?? Date()
        newTransaction.paymentTransaction = payment
                
        try! realm.write {

            updatedInformation.uang -= newTransaction.priceTransaction
            updatedInformation.pengeluaran += newTransaction.priceTransaction
            
            if categoryList.isEmpty {
                newCategory.categoryName = category
                realm.add(newCategory)
                newCategory.transactions.append(newTransaction)
                return
            }
            
            if !categoryList.isEmpty {
                for eachCategory in categoryList {
                        if eachCategory.categoryName == category {
                            eachCategory.transactions.append(newTransaction)
                            return
                        }
                    }
                newCategory.categoryName = category
                realm.add(newCategory)
                newCategory.transactions.append(newTransaction)
            }
        }
            
    }
    
}

extension TransactionSheetTableViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(valueChanged), for: .allEditingEvents)
    }
    
    @objc func valueChanged(_ textField: UITextField) {
        switch textField.tag {
        case TextFieldData.titleTextField.rawValue:
            inputNamaTextField.text = textField.text ?? ""
        case TextFieldData.priceTextField.rawValue:
            inputHargaTextField.text = textField.text ?? ""
        case TextFieldData.noteTextField.rawValue:
            inputNoteTextField.text = textField.text ?? ""

        default:
            break
        }
        validateInput()
    }
    
}


