//
//  WorkDb.swift
//  hero-app
//
//  Created by Daniel Orellana on 24/06/21.
//

import Foundation
import RealmSwift
import SwiftyJSON

class WorkDb: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var base: String = ""
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func incrementId() -> Int {
        let realm = try! Realm()
        return (realm.objects(WorkDb.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}

extension WorkDb {
    
    func populate(_ json: JSON) {
        self.id = incrementId()
        self.base = json["base"].stringValue
    }
    
}
