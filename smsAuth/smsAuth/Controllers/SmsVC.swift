//
//  SmsVC.swift
//  smsAuth
//
//  Created by Abduraxmon on 03/03/23.
//

import UIKit

class SmsVC: UIViewController {
    
    @IBOutlet weak var smsTF: UITextField!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UIView!
    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var successResendView: UIView!
    
    var minute = 60
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        startTimer()
        successResendView.isHidden = true
        
        smsTF.layer.borderWidth = 0.5
        smsTF.layer.borderColor = UIColor.gray.cgColor
        
        smsTF.attributedPlaceholder = NSAttributedString(
            string: "Placeholder Text",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    }
    
    
    @IBAction func tasdiqlashBosildi(_ sender: Any) {
        
        if let text = smsTF.text, !text.isEmpty {
            let code = text
            AuthManager.shared.verifyCode(smsCode: code) { [weak self] success in
                guard success else {return}
                let vc = AccountController(nibName: "AccountController", bundle: nil)
                vc.modalPresentationStyle = .overFullScreen
                self!.present(vc, animated: true)
            }
        }
        
    }
    
    
    @IBAction func resendPresssed(_ sender: Any) {
        if frameView.isHidden {
            minute = 60
            frameView.isHidden = false
            successResendView.isHidden = true
        }
        
        if minute == 0 {
            frameView.isHidden = true
            successResendView.isHidden = false
            let number = "+998\(text)"
            AuthManager.shared.startAuth(phoneNumber: number) { [weak self] success in
                guard success else { return }
                print("Urrra")
            }
        }
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func startTimer() {
        
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            if minute > 10 {
                minute -= 1
                timerLbl.text = "00 : \(minute)"
                restartBtn.tintColor = .gray
                restartBtn.isUserInteractionEnabled = false
            } else if minute > 0 {
                minute -= 1
                timerLbl.text = "00 : 0\(minute)"
            } else {
                restartBtn.tintColor = .white
                restartBtn.isUserInteractionEnabled = true
            }
        }
    }
    
    
}

