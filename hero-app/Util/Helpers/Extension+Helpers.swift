//
//  Extension+Helpers.swift
//  hero-app
//
//  Created by Daniel Orellana on 24/06/21.
//

import Foundation
import UIKit

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
  }
