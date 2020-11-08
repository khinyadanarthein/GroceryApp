//
//  LoginViewModel.swift
//  Grocery-App
//
//  Created by Khin Yadanar Thein on 11/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Firebase

class LoginViewModel: ObservableObject {
    @Published var mEmail : String = "";
    @Published var mPassword : String = "";
    
    @Published var isError : Bool = false;
    @Published var errorMessage: String = "";
    
    @Published var isNavigateToRegisterScreen : Bool = false;
    @Published var isNavigateToHomeScreen : Bool = false;
    
    let mAuthenticationModel : AuthenticationModel = AuthenticationModelImpl()
    let mGroceryModel : DataModel = DataModelImpl()
    
    init() {
        Analytics.logEvent(SCREEN_LOGIN, parameters: nil)
        mGroceryModel.setupRemoteConfigDefaultVlaues()
        mGroceryModel.fetchRemoteConfigs()
    }
    
    func onTapLogin(){
        Analytics.logEvent(TAP_LOGIN, parameters: [PARAM_EMAIL:mEmail])
        
        mAuthenticationModel.login(email: mEmail, password: mPassword, onSuccess: {
            self.isError = false
            self.isNavigateToHomeScreen = true
            
        }, onFailure: { error in
            DispatchQueue.main.async {
                self.errorMessage = error
                self.isError = true
            }
        })
    }
}
