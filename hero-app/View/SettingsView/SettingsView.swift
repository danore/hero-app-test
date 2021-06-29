//
//  SettingsView.swift
//  hero-app
//
//  Created by Daniel Orellana on 28/06/21.
//

import Foundation
import UIKit

class SettingsView: UIViewController {
    @IBOutlet weak var `switch`: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    @IBAction func changeUnit(_ sender: UISwitch) {
        Preferences.setParamBool("imperial", param: sender.isOn)
    }
    
    private func initialize() {
        self.switch.isOn = Preferences.getParamBool("imperial")
    }
    
}
