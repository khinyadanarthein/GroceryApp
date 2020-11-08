//
//  AuthenticationModelImpl.swift
//  Grocery-App
//
//  Created by Khin Yadanar Thein on 11/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation

class AuthenticationModelImpl : AuthenticationModel{
    
    let mAuth : AuthManager = FirebaseAuthManagerImpl()
    
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        mAuth.login(email: email, password: password, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func register(email: String, password: String, userName: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        mAuth.register(email: email, password: password, userName: userName, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getUserName() -> String {
        return mAuth.getUserName()
    }
    
}
