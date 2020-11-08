//
//  AuthenticationModel.swift
//  Grocery-App
//
//  Created by Khin Yadanar Thein on 11/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation

protocol AuthenticationModel {
    func login(email: String, password: String, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void)
    func register(email: String, password: String, userName: String, onSuccess: @escaping  () -> Void, onFailure: @escaping (String) -> Void)
    func getUserName() -> String

}
