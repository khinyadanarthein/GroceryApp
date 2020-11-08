//
//  FirebaseRemoteConfigManager.swift
//  Grocery-App
//
//  Created by Khin Yadanar Thein on 18/10/2020.
//  Copyright © 2020 Zaw Htet Naing. All rights reserved.
//

import Foundation
import FirebaseRemoteConfig

class FirebaseRemoteConfigManager {
    
    static let shared = FirebaseRemoteConfigManager()
    
    private init(){}
    
    let remoteConfig : RemoteConfig = {
        let config = RemoteConfig.remoteConfig()
        let setting = RemoteConfigSettings()
        setting.minimumFetchInterval = 0
        config.configSettings = setting
        return config
    }()
    
    func setUpRemoteConfigWithDefaultValues() {
        let defaultValues = ["mainScreenAppBarTitle" : "Grocery-App" as NSObject]
        remoteConfig.setDefaults(defaultValues)
    }
    
    func fetchRemoteConfig() {
        remoteConfig.fetch { (status, error) in
            if status == .success {
                print("fetched config")
                self.remoteConfig.activate { (changed, error) in
                    print("confid updated")
                }
            } else {
                print("fetched failed")
            }
        }
    }
    
    func getAppBarName() -> String {
        return remoteConfig.configValue(forKey: "mainScreenAppBarTitle").stringValue ?? ""
    }
    
    func getListStyle() -> Int {
        let value = remoteConfig.configValue(forKey: "list_style").stringValue ?? "0"
        return Int(value) ?? 0
    }
}
