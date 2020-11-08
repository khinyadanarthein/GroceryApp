//
//  DataModel.swift
//  Grocery-App
//
//  Created by Khin Yadanar Thein on 20/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation

protocol DataModel {
    
    func getGroceries(success : @escaping ([GroceryVO]) -> Void, fail : @escaping (String) -> Void)
    func addGrocery(grocery : GroceryVO, image : Data,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
    func deleteGrocery(grocery : GroceryVO)
    func onUploadImage(image : Data, grocery : GroceryVO ,success : @escaping (String) -> Void, fail : @escaping (String) -> Void)
    func setupRemoteConfigDefaultVlaues()
    func fetchRemoteConfigs()
    func getAppBarNameFromRemoteConfig() -> String
    func getListStyle() -> Int
}
