//
//  MenuViewController.swift
//  Pengeluaranku
//
//  Created by Hada on 02/02/21.
//

import UIKit
import RealmSwift

class MenuViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var pendapatanInput: UITextField!
    @IBOutlet weak var uangSaatIniInput: UITextField!

    
    var isReadyToGo: Bool = false
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        pendapatanInput.placeholder = "Pendapatan"
        uangSaatIniInput.placeholder = "Uang Saat Ini"
    }
    
    @IBAction func continueDidTap(_ sender: UIButton) {
        
        performSegue(withIdentifier: Source.menuToTabIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let pendapatan = pendapatanInput.text, !pendapatan.isEmpty, let uang = uangSaatIniInput.text, !uang.isEmpty {
 
            saveInput()
            
        } else {
            let alert = UIAlertController(title: "Periksa kembali input kamu!", message: "Kami membutuhkan informasi di atas untuk dapat melanjutkan", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func saveInput(){
        let updateUserInformation = UserInformation()
        
        updateUserInformation.pendapatan = Int(pendapatanInput!.text!)!
        updateUserInformation.uang = Int(uangSaatIniInput!.text!)!
        
        try! realm.write {
            realm.add(updateUserInformation)
        }
    }

}


