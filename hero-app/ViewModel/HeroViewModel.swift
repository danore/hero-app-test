//
//  HeroViewModel.swift
//  hero-app
//
//  Created by Daniel Orellana on 24/06/21.
//

import Foundation
import SwiftyJSON
import RealmSwift

class HeroViewModel {
    
    var webService: NetworkManager
    var list: [HeroDb] = []
    
    init() {
        self.webService = NetworkManager()
    }
    
    func search(_ param: String, completion: @escaping (String) ->(), onFailure: @escaping (String) -> ()) {        
        self.webService.request(API_URI, queryParams: param, method: .get) { data in
            var result: [HeroDb] = []
            
            guard let info = data else {
                onFailure("Results not found")
                return
            }
            
            do {
                let json = try JSON(data: info)
                let jsonArray = json["results"]
                for jsonData in jsonArray.arrayValue {
                    let biography = BiographyDb()
                    biography.populate(jsonData["biography"])
                    
                    let appearance = AppearanceDb()
                    appearance.populate(jsonData["appearance"])
                    
                    let work = WorkDb()
                    work.populate(jsonData["work"])
                    
                    let connection = ConnectionDb()
                    connection.populate(jsonData["connections"])
                    
                    let entity = HeroDb()
                    entity.id = entity.incrementId()
                    entity.populate(jsonData)
                    entity.biography = biography
                    entity.appearance = appearance
                    entity.work = work
                    entity.connection = connection
                    entity.isFavorite = self.exist(entity.hero_id)
                    
                    result.append(entity)
                }
                
                self.list = result
                completion("Success")
            }catch {
                print("ERROR:", error)
                onFailure("Parse data error")
            }
        }
    }
    
    func getHeros() {
        self.list = self.findAll()
    }
    
    private func findAll() ->[HeroDb]{
        let realm = try! Realm()
        var result = [HeroDb]()
        
        let data = realm.objects(HeroDb.self)
        
        for info in data {
            info.isFavorite = true
            result.append(info)
        }
                
        return result
    }
    
    func exist(_ id: Int) ->Bool{
        let realm = try! Realm()
        
        return realm.objects(HeroDb.self).filter("hero_id == \(id)").count > 0
    }
    
    func save(_ data: HeroDb){
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(data.appearance!)
            realm.add(data.biography!)
            realm.add(data.work!)
            realm.add(data.connection!)
            realm.add(data)
        }
    }
    
    func remove(_ data: HeroDb){
        let realm = try! Realm()
        let heroId: Int = data.id
        let appearanceId: Int = data.appearance!.id
        let biographyId: Int = data.biography!.id
        let workId: Int = data.work!.id
        let connectionId: Int = data.connection!.id
        
        try! realm.write {
            realm.delete(realm.objects(AppearanceDb.self).filter("id == \(appearanceId)"))
            realm.delete(realm.objects(BiographyDb.self).filter("id == \(biographyId)"))
            realm.delete(realm.objects(WorkDb.self).filter("id == \(workId)"))
            realm.delete(realm.objects(ConnectionDb.self).filter("id == \(connectionId)"))
            realm.delete(realm.objects(HeroDb.self).filter("id == \(heroId)"))
        }
    }
    
}
