//
//  UserDefaults+Extension.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/26/25.
//

import Foundation

extension UserDefaults {
    
    private enum Keys {
        static let isBegginer = "isBegginer"
        static let uuid = "uuid"
        static let companyName = "companyName"
    }
    
    var isBegginer: Bool {
        get {
            bool(forKey: Keys.isBegginer)
        }
        set {
            set(newValue, forKey: Keys.isBegginer)
        }
    }
    
    var uuid: String {
        get {
            string(forKey: Keys.uuid) ?? ""
        }
        set {
            set(newValue, forKey: Keys.uuid)
        }
    }
    
    var companyName: String {
        get {
            string(forKey: Keys.companyName) ?? ""
        }
        set {
            set(newValue, forKey: Keys.companyName)
        }
    }
}
