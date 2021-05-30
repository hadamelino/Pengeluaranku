//
//  ViewController.swift
//  Pengeluaranku
//
//  Created by Hada on 02/02/21.
//

import UIKit
import RealmSwift
import Canvas

class HomeViewController: UIViewController, UITableViewDelegate {
  
    @IBOutlet weak var inOutMoneyTable: UITableView!
    @IBOutlet weak var uangkuLabel: UILabel!
    @IBOutlet weak var pendapatanLabel: UILabel!
    @IBOutlet weak var pengeluaranLabel: UILabel!
    @IBOutlet weak var editButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var pendapatanAnim: CSAnimationView!
    @IBOutlet weak var uangkuAnim: CSAnimationView!
    @IBOutlet weak var pengeluaranAnim: CSAnimationView!
    
    var textFieldPendapatan = UITextField()
    var textFieldUang = UITextField()
    var addButton = UIAlertAction()
    var updateButton = UIAlertAction()
    
    var inputNamaTextField = UITextField()
    var inputHargaTextField = UITextField()
    var inputMetodePemTextField = UITextField()
    
    let source = Source()
    let realm = try! Realm()
    
    var transactionList: Results<Transaction>?
    var userInformations: Results<UserInformation>?
   
// MARK: - View Did load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(realm.configuration.fileURL)
        self.hideKeyboardWhenTappedAround()

        loadData()

        inOutMoneyTable.backgroundColor = .systemBackground
        inOutMoneyTable.separatorColor = .secondaryLabel
        
        inOutMoneyTable.delegate = self
        inOutMoneyTable.dataSource = self
        inOutMoneyTable.register(UINib(nibName: Source.nibName, bundle: nil), forCellReuseIdentifier: Source.cellIdentifier)
        
        inOutMoneyTable.separatorStyle = .singleLine
        
        uangkuLabel.sizeToFit()
        uangkuLabel.adjustsFontSizeToFitWidth = true
        pendapatanLabel.sizeToFit()
        pendapatanLabel.adjustsFontSizeToFitWidth = true
        pengeluaranLabel.sizeToFit()
        pengeluaranLabel.adjustsFontSizeToFitWidth = true

        uangkuLabel.text = source.formatted(from: userInformations?.first?.uang ?? 0)
        pendapatanLabel.text = source.formatted(from: userInformations?.first?.pendapatan ?? 0)
        pengeluaranLabel.text = source.formatted(from: userInformations?.first?.pengeluaran ?? 0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let tabBar = tabBarController?.tabBar else {fatalError("Tab bar failed to load")}
        tabBar.tintColor = .label
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        let destinationVC = storyboard?.instantiateViewController(identifier: "transactionSheet") as! TransactionSheetTableViewController
        destinationVC.updateDelegate = self
        present(UINavigationController(rootViewController: destinationVC), animated: true, completion: nil)
    }
    
    @IBAction func settingButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Change Information", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Done", style: .default) {action in
            
            if let informations = self.realm.objects(UserInformation.self).first {
        
            try! self.realm.write {
                informations.pendapatan = Int(self.textFieldPendapatan.text!)!
                informations.uang = Int(self.textFieldUang.text!)! - informations.pengeluaran
            }
            } else {
                let information = UserInformation()
                information.pendapatan = Int(self.textFieldPendapatan.text!)!
                information.uang = Int(self.textFieldUang.text!)!
                try! self.realm.write {
                    self.realm.add(information)
                }
            }
            
            self.pendapatanLabel.text = self.source.formatted(from: self.userInformations?.first?.pendapatan ?? 0)
            self.pengeluaranLabel.text = self.source.formatted(from: self.userInformations?.first?.pengeluaran ?? 0)
            self.uangkuLabel.text = self.source.formatted(from: self.userInformations?.first?.uang ?? 0)
            
            self.animateView(view: self.pendapatanAnim)
            self.animateView(view: self.uangkuAnim)
            }
       
        updateButton = action
        
        alert.addTextField {(pendapatan) in
            self.textFieldPendapatan = pendapatan
            pendapatan.addTextFieldToAlert(textField2: self.textFieldPendapatan, isNumberInput: true, vc: self, placeholder: "Pendapatan")
        }
        alert.addTextField {(uangSaatIni) in
                self.textFieldUang = uangSaatIni
                uangSaatIni.addTextFieldToAlert(textField2: self.textFieldUang, isNumberInput: true, vc: self, placeholder: "Uang Saat Ini")
            
        }
    
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        action.isEnabled = false
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        self.inOutMoneyTable.isEditing = !self.inOutMoneyTable.isEditing
        sender.title = (self.inOutMoneyTable.isEditing) ? "Done" : "Edit"
    }
    
    //MARK: - Save and Load Data
    func loadData() {
        transactionList = realm.objects(Transaction.self).sorted(byKeyPath: "dateTransaction", ascending: false)
        userInformations = realm.objects(UserInformation.self)
    }
    
    //MARK: - CSAnimationView
    func animateView(view: CSAnimationView){
        view.type = "pop"
        view.duration = 0.5
        view.delay = 0.5
        view.startCanvasAnimation()
    }
    
}

    
    //MARK: - TableView DataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if transactionList?.count == 0 {
            inOutMoneyTable.showPlaceHolder(message: "Belum Ada Transaksi")
        } else {
            inOutMoneyTable.hidePlaceHolder()
        }
        
        return transactionList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Source.cellIdentifier, for: indexPath) as! TransactionTableViewCell
        
        if inOutMoneyTable.isEditing {

        }
        
        if let list = transactionList {
            
            inOutMoneyTable.tableFooterView = UIView(frame: .zero)
            
            cell.nameOfTransaction.text = list[indexPath.row].transactionName
            cell.priceTransaction.text = source.formatted(from: list[indexPath.row].priceTransaction)
            cell.paymentTransaction.text = list[indexPath.row].paymentTransaction
            cell.dateTransaction.text = list[indexPath.row].dateTransaction.toString(dateFormat: "dd MMM YYYY")
            cell.transactionCount.text = String(list.count - indexPath.row)
            cell.textLabel?.textAlignment = .center
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let transactions = transactionList {
                
                if transactions.isEmpty {
                    editButtonOutlet.title = "Edit"
                }
                
            try! realm.write {
                userInformations?.first?.pengeluaran -= transactions[indexPath.row].priceTransaction
                pengeluaranLabel.text = source.formatted(from: userInformations?.first?.pengeluaran ?? 0)
                
                userInformations?.first?.uang += transactions[indexPath.row].priceTransaction
                uangkuLabel.text = source.formatted(from: userInformations?.first?.uang ?? 0)
                
                self.animateView(view: uangkuAnim)
                self.animateView(view: pengeluaranAnim)
                
                self.realm.delete(transactions[indexPath.row])
                
                }
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.inOutMoneyTable.reloadData()

            }
            
        }
    }
}

    //MARK: - TextField Delegate
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text1 = self.textFieldPendapatan.text ?? ""
        let text2 = self.textFieldUang.text ?? ""
        
        if !text1.isEmpty && !text2.isEmpty {
            updateButton.isEnabled = true
        } else {
            updateButton.isEnabled = false
        }
        
        let text3 = self.inputNamaTextField.text ?? ""
        let text4 = self.inputHargaTextField.text ?? ""
        let text5 = self.inputMetodePemTextField.text ?? ""

        if !text3.isEmpty && !text4.isEmpty && !text5.isEmpty {
            addButton.isEnabled = true
        } else {
            addButton.isEnabled = false
        }

    }
}

extension HomeViewController: UpdateDelegate {
    
    func didUpdateData(_ sender: TransactionSheetTableViewController) {
        
        loadData()
        
        let information = realm.objects(UserInformation.self).first!
        
        pengeluaranLabel.text = source.formatted(from: information.pengeluaran)
        uangkuLabel.text = source.formatted(from: information.uang)
        pendapatanLabel.text = source.formatted(from: information.pendapatan)
        
        animateView(view: uangkuAnim)
        
        inOutMoneyTable.reloadData()
        }
}







