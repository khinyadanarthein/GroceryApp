//
//  FirebaseAuthManagerImpl.swift
//  Grocery-App
//
//  Created by Khin Yadanar Thein on 11/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAuthManagerImpl: AuthManager {
    
    let firebaseAuth = Auth.auth()
    
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        
        firebaseAuth.signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                onFailure(error.localizedDescription)
            } else {
                onSuccess()
            }
        }
    }
    
    func register(email: String, password: String, userName: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        
        firebaseAuth.createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                onFailure(error.localizedDescription)
            } else {
                guard let user = self.firebaseAuth.currentUser else { return }
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = userName
                changeRequest.commitChanges { (error) in
                    if let error = error {
                        onFailure(error.localizedDescription)
                    } else {
                        onSuccess()
                    }
                }
            }
        }
    }
    
    func getUserName() -> String {
        
        return firebaseAuth.currentUser?.displayName ?? ""
    }
    
    
}
