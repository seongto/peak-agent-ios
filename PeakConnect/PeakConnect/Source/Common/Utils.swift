//
//  Utils.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/26/25.
//

import UIKit

class Utils {
    
    static func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
