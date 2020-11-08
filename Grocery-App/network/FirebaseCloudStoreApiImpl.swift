//
//  FirebaseCloudStoreApiImpl.swift
//  Grocery-App
//
//  Created by Khin Yadanar Thein on 26/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class FirebaseCloudStoreApiImpl: FirebaseApi {
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func getGroceryList(success: @escaping ([GroceryVO]) -> Void, fail: @escaping (String) -> Void) {
        
        db.collection("groceries").addSnapshotListener { (snapshot, error) in
            var groceriesList = [GroceryVO]()
            
            snapshot?.documents.forEach({ (singleSnapshot) in
                
                let grocery = GroceryVO()
                grocery.name = singleSnapshot["name"] as? String
                grocery.description = singleSnapshot["description"] as? String
                grocery.amount = singleSnapshot["amount"] as? Int
                grocery.image = singleSnapshot["image"] as? String
                
                groceriesList.append(grocery)
            })
            success(groceriesList)
        }
    }
    
    func addNewGrocery(grocery: GroceryVO) {
        let groceryDic : [String:Any] = [
            "name" : grocery.name ?? "",
            "description" : grocery.description ?? "",
            "amount" : grocery.amount ?? 0,
            "image" : grocery.image ?? ""
        ]
        
        db.collection("groceries")
            .document(grocery.name ?? "")
            .setData(groceryDic) { err in
                if let error = err{
                    print("Failed to add data => \(error.localizedDescription)")
                } else{
                    print("Successfully add data")
                }
            }
    }
    
    func deleteGrocery(grocery: GroceryVO) {
        
        db.collection("groceries")
            .document(grocery.name ?? "")
            .delete { (error) in
                if let err = error{
                    print("Failed to delete data => \(err.localizedDescription)")
                } else{
                    print("Successfully delete data")
                }
        }
    }
    
    func uploadImage(imageData: Data, grocery: GroceryVO,success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        let storageRef = storage.reference()
        
        let groceryImageRef = storageRef.child("images/\(UUID().uuidString).jpg")

        groceryImageRef.putData(imageData, metadata: nil) { (metadata, error) in
            groceryImageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    return
                }
                grocery.image = downloadURL.absoluteString
                self.addNewGrocery(grocery: grocery)
                success("success")
            }
        }

    }
    
}
