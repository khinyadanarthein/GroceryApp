//
//  DataModelImpl.swift
//  Grocery-App
//
//  Created by Khin Yadanar Thein on 20/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation

class DataModelImpl: DataModel {
    
    let api : FirebaseApi = FireBaseApiClient()
    let cloudApi : FirebaseApi = FirebaseCloudStoreApiImpl()
    let firebaseRemoteConfig : FirebaseRemoteConfigManager = FirebaseRemoteConfigManager.shared
    
    func getGroceries(success: @escaping ([GroceryVO]) -> Void, fail: @escaping (String) -> Void) {
        api.getGroceryList(success: success, fail: fail)
        //cloudApi.getGroceryList(success: success, fail: fail)
    }
    
    
    func addGrocery(grocery: GroceryVO, image: Data, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {

        api.uploadImage(imageData: image, grocery: grocery, success: success, fail: fail)
        //api.addNewGrocery(grocery: grocery)
        //cloudApi.addNewGrocery(grocery: grocery)
    }
    
    func deleteGrocery(grocery: GroceryVO) {
        api.deleteGrocery(grocery: grocery)
        //cloudApi.deleteGrocery(grocery: grocery)
    }
    
    func onUploadImage(image: Data, grocery: GroceryVO, success: @escaping (String) -> Void, fail: @escaping (String) -> Void ) {
        api.uploadImage(imageData: image, grocery: grocery, success: success, fail: fail)
        //cloudApi.uploadImage(imageData: image, grocery: grocery)
    }
    
    func setupRemoteConfigDefaultVlaues() {
        firebaseRemoteConfig.setUpRemoteConfigWithDefaultValues()
    }
    
    func fetchRemoteConfigs() {
        firebaseRemoteConfig.fetchRemoteConfig()
    }
    
    func getAppBarNameFromRemoteConfig() -> String {
        return firebaseRemoteConfig.getAppBarName()
    }
    
    func getListStyle() -> Int {
        return firebaseRemoteConfig.getListStyle()
    }
}
