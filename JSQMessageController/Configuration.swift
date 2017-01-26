//
//  Configuration.swift
//  JSQMessageController
//
//  Created by Orange Apps on 21/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit

class Configuration: NSObject {
    
    public static func urlStr(urlData: String) -> String {
        return "http://192.168.1.21/ci_api/index.php/"+urlData
    }
    
}
