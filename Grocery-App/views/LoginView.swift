//
//  LoginView.swift
//  Grocery-App
//
//  Created by Khin Yadanar Thein on 11/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var mLoginViewModel = LoginViewModel()
    
    var body: some View {
        
        NavigationView{
            VStack(spacing: 16){
                Image("grocery")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .cornerRadius(8)
                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 32, trailing: 0))
                
                TextField("Email", text: $mLoginViewModel.mEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $mLoginViewModel.mPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                NavigationLink(destination: ContentView(), isActive: $mLoginViewModel.isNavigateToHomeScreen){
                    Button(action: {
                        //fatalError()
                        self.mLoginViewModel.onTapLogin()
                    }){
                        Text("LOGIN")
                            .padding(EdgeInsets.init(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .cornerRadius(16)
                }
                
                
                NavigationLink(destination: RegisterView(), isActive: self.$mLoginViewModel.isNavigateToRegisterScreen){
                    Button(action:{
                        self.mLoginViewModel.isNavigateToRegisterScreen = true
                    }){
                        HStack{
                            Text("Don't have an account?")
                                .foregroundColor(Color.black)
                            Text("Register")
                                .foregroundColor(Color.green)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .alert(isPresented: self.$mLoginViewModel.isError) {
                return Alert(title: Text(mLoginViewModel.errorMessage))
            }
        }
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
