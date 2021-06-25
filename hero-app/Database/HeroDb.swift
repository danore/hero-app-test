//
//  HeroDb.swift
//  hero-app
//
//  Created by Daniel Orellana on 24/06/21.
//

import Foundation
import RealmSwift
import Realm
import SwiftyJSON

class HeroDb: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var hero_id: Int = 0
    @objc dynamic var intelligence: Int = 0
    @objc dynamic var strength: Int = 0
    @objc dynamic var speed: Int = 0
    @objc dynamic var durability: Int = 0
    @objc dynamic var power: Int = 0
    @objc dynamic var combat: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var biography: BiographyDb?
    @objc dynamic var appearance: AppearanceDb?
    @objc dynamic var work: WorkDb?
    @objc dynamic var connection: ConnectionDb?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func incrementId() -> Int {
        let realm = try! Realm()
        return (realm.objects(HeroDb.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}

extension HeroDb {
    func populate(_ json: JSON) {
        let powerstats = json["powerstats"]
        
        self.id = self.incrementId()
        self.hero_id = json["id"].intValue
        self.intelligence = powerstats["intelligence"].intValue
        self.strength = powerstats["strength"].intValue
        self.speed = powerstats["speed"].intValue
        self.durability = powerstats["durability"].intValue
        self.power = powerstats["power"].intValue
        self.combat = powerstats["combat"].intValue
        self.name = json["name"].stringValue
        self.image = json["image"][0].stringValue
    }
}
