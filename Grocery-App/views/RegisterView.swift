//
//  RegisterView.swift
//  Grocery-App
//
//  Created by Khin Yadanar Thein on 11/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var mRegisterViewModel = RegisterViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 16){
            Image("carrot")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .cornerRadius(8)
                .background(Color.green)
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 32, trailing: 0))
            
            TextField("Email", text: $mRegisterViewModel.mEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Password", text: $mRegisterViewModel.mPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("User Name", text: $mRegisterViewModel.mUserName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                self.mRegisterViewModel.onTapRegister(onSuccess: {
                    self.presentationMode.wrappedValue.dismiss()
                })
            }){
                Text("REGISTER")
                    .padding(EdgeInsets.init(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(Color.white)
            }
            .padding()
            .cornerRadius(16)
            
            
        }
        .alert(isPresented: self.$mRegisterViewModel.isError) {
            return Alert(title: Text(mRegisterViewModel.errorMessage))
        }
    }
}


struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

