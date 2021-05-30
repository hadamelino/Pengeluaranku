import UIKit

extension UITableView {
    func showPlaceHolder(message text: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .placeholderText
        label.backgroundColor = .systemBackground
        label.text = text
        label.textAlignment = .center
        
        self.isScrollEnabled = false
        self.backgroundView = label
        self.separatorStyle = .none
    }
    func hidePlaceHolder() {
        self.separatorStyle = .singleLine
        self.backgroundView = nil
        self.isScrollEnabled = true
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UITextField {
    
    func addTextFieldToAlert(textField2: UITextField, isNumberInput: Bool, vc: UITextFieldDelegate, placeholder: String?) {
        textField2.delegate = vc
        if isNumberInput {
            textField2.keyboardType = .numberPad
        }
        textField2.placeholder = placeholder
    }
    
}

extension Date
{
    func toString(dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}


