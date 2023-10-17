//
//  Helper.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/17/23.
//

import Foundation

class Helper: NSObject {
    
    // Offline
    class func checkNetwork()->String {
        let check_network = "network"
        return check_network
    }
    class func SaveCheckNetwork(check : String?){
        let def = UserDefaults.standard
        def.setValue(check, forKey: checkNetwork())
        def.synchronize()
    }
    
    class func getCheckNetwork()->String? {
        let def = UserDefaults.standard
        return def.object(forKey: checkNetwork()) as? String
    }
}
