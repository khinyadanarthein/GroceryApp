//
//  FirebaseApi.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation

protocol FirebaseApi {
    
    func getGroceryList(success : @escaping ([GroceryVO]) -> Void, fail : @escaping (String) -> Void)
    func addNewGrocery(grocery :GroceryVO)
    func deleteGrocery(grocery : GroceryVO)
    func uploadImage(imageData : Data, grocery : GroceryVO,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
}

