//
//  MainView.swift
//  hero-app
//
//  Created by Daniel Orellana on 28/06/21.
//

import Foundation
import UIKit

class MainView: UIViewController {
    
    var heroEntity: HeroDb?
    
    func showError(_ text: String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destViewController = segue.destination as! UINavigationController
        
        if (segue.identifier!.elementsEqual("DetailView")) {
            if let destViewController : DetailView = destViewController.topViewController as? DetailView {
                destViewController.hero = self.heroEntity
            }
        }
    }
    
}
