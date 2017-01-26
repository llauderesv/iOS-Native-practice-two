//
//  UserDefaults.swift
//  JSQMessageController
//
//  Created by Orange Apps on 22/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit

class UserDef {
    
    let preferences = UserDefaults.standard
    
    public func addValue(identifier: String, value: String) {
    
        preferences.set(value, forKey: identifier)
        
        preferences.synchronize()
        
    }
    
    public func readValue(identifier: String) -> String {
        
        return preferences.object(forKey: identifier) as! String
        
    }
    
    
}
