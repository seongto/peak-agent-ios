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
    }
    
    var isBegginer: Bool {
        get {
            bool(forKey: Keys.isBegginer)
        }
        set {
            set(newValue, forKey: Keys.isBegginer)
        }
    }
}
