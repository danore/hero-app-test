//
//  HeroViewModel.swift
//  hero-app
//
//  Created by Daniel Orellana on 24/06/21.
//

import Foundation
import SwiftyJSON

class HeroViewModel {
    
    var webService: NetworkManager
    
    init() {
        self.webService = NetworkManager()
    }
    
    func search(_ completion: @escaping ([HeroDb]) ->(), onFailure: @escaping (String) -> ()) {
        self.webService.request(API_URI, queryParams: "bat", method: .get) { data in
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
                    
                    result.append(entity)
                }
                
                completion(result)
            }catch {
                print("ERROR:", error)
                onFailure("Parse data error")
            }
        }
    }
    
}
