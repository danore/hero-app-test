//
//  ConnectionDb.swift
//  hero-app
//
//  Created by Daniel Orellana on 24/06/21.
//

import Foundation
import RealmSwift
import SwiftyJSON

class ConnectionDb: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var relatives: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func incrementId() -> Int {
        let realm = try! Realm()
        return (realm.objects(ConnectionDb.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
}

extension ConnectionDb {
    
    func populate(_ json: JSON) {
        self.id = incrementId()
        self.relatives = json["relatives"].stringValue
    }
    
}
