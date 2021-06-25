//
//  HeroView.swift
//  hero-app
//
//  Created by Daniel Orellana on 24/06/21.
//

import Foundation
import UIKit

class HeroView: UIViewController {
    
    let heroVM = HeroViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    private func initialize() {
        self.heroVM.search { response in
            for data in response {
                print(data.biography?.aliases ?? "Not exist")
                print(data.name)
            }
        } onFailure: { error in
            print(error)
        }

    }
    
}
