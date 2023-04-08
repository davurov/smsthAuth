//
//  PhoneVC.swift
//  smsAuth
//
//  Created by Abduraxmon on 03/03/23.
//

import UIKit

class PhoneVC: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var frameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        frameView.layer.borderWidth = 0.5
        frameView.layer.borderColor = UIColor.gray.cgColor
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Placeholder Text",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
    }
    
    
    @IBAction func kirishPressed(_ sender: Any) {
        //textField.resignFirstResponder()
        
        if let text = textField.text, !text.isEmpty {
            let number = "+998\(text)"
            AuthManager.shared.startAuth(phoneNumber: number) { [weak self] success in
                guard success else { return }
                let vc = SmsVC(nibName: "SmsVC", bundle: nil)
                vc.modalPresentationStyle = .overFullScreen
                self!.present(vc, animated: true)
                vc.text = text
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
