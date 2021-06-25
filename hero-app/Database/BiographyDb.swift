//
//  BiographyDb.swift
//  hero-app
//
//  Created by Daniel Orellana on 24/06/21.
//

import Foundation
import RealmSwift
import SwiftyJSON

class BiographyDb: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var full_name: String = ""
    @objc dynamic var aliases: String = ""
    @objc dynamic var alter_egos: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func incrementId() -> Int {
        let realm = try! Realm()
        return (realm.objects(BiographyDb.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}

extension BiographyDb {
    
    func populate(_ json: JSON) {
        print(json)
        self.id = self.incrementId()
        self.full_name = json["full-name"].stringValue
        self.alter_egos = json["alter-egos"].stringValue
        json["aliases"].arrayValue.forEach{ self.aliases += "\($0)," }
    }
    
}
