//
//  GroceryViewModel.swift
//  Grocery-App
//
//  Created by Zaw Htet Naing on 18/09/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import Firebase

class GroceryViewModel : ObservableObject{
    
    @Published var groceries : [GroceryVO] = []
    @Published var isAddPopOverShown : Bool = false
    @Published var isUpdatePopOverShown : Bool = false
    
    @Published var image : UIImage = UIImage(systemName: "cart")!
    @Published var groceryName : String = ""
    @Published var groceryDescription : String = ""
    @Published var groceryAmount : String = ""
    
    // image picker
    @Published var isShowingImage : Bool = false
    @Published var chosenImage : UIImage = UIImage()
    
    //Chosen Grocery
    var chosenGrocery : GroceryVO? = nil
    
    // user name
    @Published var appBarName : String = ""
    
    // list view style
    @Published var listStyle : Int = 0
    
    // activity indicator
    @Published var hideIndicator : Bool = false
    @Published var showImageloading : Bool = true
    
    let model : DataModel = DataModelImpl()
    let authModel : AuthenticationModel = AuthenticationModelImpl()
    
    init() {
        model.getGroceries(success: { (list) in
            self.groceries = list
            self.hideIndicator = true
            
        }) { (error) in
            debugPrint(error)
        }
        // set up usename for app bar
        //getUserName()
        
        Analytics.logEvent(SCREEN_HOME, parameters: nil)
        // get app bar name from config
        self.appBarName = model.getAppBarNameFromRemoteConfig()
        self.listStyle = model.getListStyle()
    }
    
    func refreshView() {
        groceryName = ""
        groceryDescription = ""
        groceryAmount = ""
        image = UIImage(systemName: "cart")!.withTintColor(UIColor.systemGray)
    }
    
    func onTapAddGrocery(){
        let grocery = GroceryVO()
        grocery.name = groceryName
        grocery.description = groceryDescription
        grocery.amount = Int(groceryAmount) ?? 0
        let imageData = image.jpegData(compressionQuality: 0.5) ?? Data()
        self.hideIndicator = false
        model.addGrocery(grocery: grocery, image: imageData, success: { (message) in
            self.hideIndicator = true
        }) { (error) in
            self.hideIndicator = true
            
        }
    }
    
    func onTapEditGrocery(groceryName: String , groceryDescription : String, groceryAmount: String, imageURL : String){
        self.groceryName = groceryName
        self.groceryDescription = groceryDescription
        self.groceryAmount = groceryAmount
        self.image = UIImage()
        // open indicator
        DispatchQueue.global(qos: .background).async {
            do
            {
                let data = try Data.init(contentsOf: URL.init(string:imageURL)!)
                DispatchQueue.main.async {
                    // closed indicator
                    self.image = UIImage(data: data) ?? UIImage()
                    self.showImageloading = false
                }
            }
            catch {
                self.image = UIImage()
                
            }
        }
    }
    
    func onDeleteGrocery(grocery : GroceryVO) {
        model.deleteGrocery(grocery: grocery)
    }
    
    func onGroceryItemChosen(grocery : GroceryVO){
        self.chosenGrocery = grocery
    }
    
    func onImageChosen(image : UIImage){
        guard let chosenGrocery = self.chosenGrocery else { return }
        model.onUploadImage(image: image.jpegData(compressionQuality: 1.0) ?? Data(), grocery: chosenGrocery, success: { (message) in

        }) { (error) in
            
        }
    }
    
    func onRegisterImage(image : UIImage){
        self.image = image
    }

    func getUserName() {
        self.appBarName = authModel.getUserName()
    }
}
