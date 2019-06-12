//
//  SWFWorkString.swift
//  eCardio
//
//  Created by MacBook Pro on 9/10/18.
//  Copyright © 2018 Wolves. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var hexColor: UIColor {
        
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        
    }
    
    func replace(target: String, withString: String) -> String {
        
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
        
    }
    
    func randomAlphaNumericString(length: Int) -> String {
        
        let charactersString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-=!@#$%^&*()_+"
    
        var string = ""
        for _ in 0..<length {
            var i = 0
            for char in charactersString {
                if i == Int(arc4random()) % charactersString.count {
                    string.append(char)
                    break
                } else {
                    i += 1
                }
            }
        }
        
        return string
        
    }
    
}
