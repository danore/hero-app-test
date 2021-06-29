//
//  Preferences+Helper.swift
//  hero-app
//
//  Created by Daniel Orellana on 28/06/21.
//

import Foundation


class Preferences {
    
    class func setParam(_ key: String, param: String) {
        let defaults = UserDefaults.standard
        defaults.set(param, forKey: key)
    }
    
    class func getParam(_ key: String) -> String {
        let defaults = UserDefaults.standard
        let result = defaults.string(forKey: key);
        
        return result != nil ? result! : ""
    }
    
    class func setParamBool(_ key: String, param: Bool){
        let defaults = UserDefaults.standard
        defaults.set(param, forKey: key)
    }
    
    class func getParamBool(_ keyBool: String) ->Bool{
        let defaults = UserDefaults.standard
        let result = defaults.bool(forKey: keyBool)
        
        return result
    }
    
}
