//
//  AppearanceDb.swift
//  hero-app
//
//  Created by Daniel Orellana on 24/06/21.
//

import Foundation
import RealmSwift
import SwiftyJSON

class AppearanceDb: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var gender: String = ""
    @objc dynamic var race: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var weight: String = ""
    @objc dynamic var eye_color: String = ""
    @objc dynamic var hair_color: String = ""
        
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func incrementId() -> Int {
        let realm = try! Realm()
        return (realm.objects(AppearanceDb.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}

extension AppearanceDb {
    func populate(_ json: JSON) {
        self.id = self.incrementId()
        self.gender = json["gender"].stringValue
        self.race = json["race"].stringValue
        self.height = json["height"].stringValue
        self.weight = json["weight"].stringValue
        self.eye_color = json["eye-color"].stringValue
        self.hair_color = json["hair-color"].stringValue
        
        json["height"].arrayValue.forEach{ self.height += "\($0)," }
        json["weight"].arrayValue.forEach{ self.weight += "\($0)," }
    }
    
}
