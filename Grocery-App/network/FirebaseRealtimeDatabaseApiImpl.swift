//
//  FirebaseRealtimeDatabaseApiImpl.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class FireBaseApiClient : FirebaseApi {
    
    var realTimeDB : DatabaseReference = Database.database().reference()
    
    var storage = Storage.storage()
    
    func getGroceryList(success: @escaping ([GroceryVO]) -> Void, fail: @escaping (String) -> Void) {
        
        realTimeDB.child("grocery").observe(DataEventType.value, with : { (snapshot) in
            
            var groceries : [GroceryVO] = []
            
            snapshot.children.forEach { (singleSnapShot) in
                
                let grocery = GroceryVO()
                let groceryDic = (singleSnapShot as?  DataSnapshot)?.value as? [String : Any] ?? [:]
                grocery.name = groceryDic["name"] as? String
                grocery.description = groceryDic["description"] as? String
                grocery.amount = groceryDic["amount"] as? Int
                grocery.image = groceryDic["image"] as? String
                
                groceries.append(grocery)
            }
            success(groceries)
        })
    }
    
    func addNewGrocery(grocery: GroceryVO) {
        
        realTimeDB.child("grocery").child(grocery.name ?? "").setValue([
            "name" : grocery.name ?? "",
            "description" : grocery.description ?? "",
            "amount" : grocery.amount ?? 0,
            "image" : grocery.image ?? ""
        ])
    }
    
    func deleteGrocery(grocery: GroceryVO) {
        realTimeDB.child("grocery").child(grocery.name ?? "").removeValue()
    }
    
    func uploadImage(imageData: Data, grocery: GroceryVO,success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        let storageRef = storage.reference()
        
        let groceryImageRef = storageRef.child("images/\(grocery.name!).jpg")
        groceryImageRef.putData(imageData,metadata: nil) { (metadata , error) in
            groceryImageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("\(error?.localizedDescription ?? "")")
                    fail(error.debugDescription)
                    return
                }
                grocery.image = downloadURL.absoluteString
                self.addNewGrocery(grocery: grocery)
                success("Success")
            }
            
        }
    }
}
