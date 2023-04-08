//
//  AuthManager.swift
//  smsAuth
//
//  Created by Abduraxmon on 03/03/23.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    private let auth = Auth.auth()
    private  var verificationId: String?
    
    public func startAuth(phoneNumber: String, complition: @escaping (Bool) -> Void ) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
            guard let verificationId = verificationId, error == nil else {
                print(error)
                complition(false)
                return
            }
            self?.verificationId = verificationId
            complition(true)
        }
    }
    
    public func verifyCode(smsCode: String, complition: @escaping (Bool) -> Void) {
        
        guard let verificationId = verificationId else {
            complition(false)
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: smsCode)
        
        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                complition(false)
                return
            }
            complition(true)
        }
        
    }
}
