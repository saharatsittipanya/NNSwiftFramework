//
//  NNFWorkNumeral.swift
//  BCPGEcolife
//
//  Created by Saharat Sittipanya on 18/3/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    
    func addCommas(Decimal number: Int) -> String {
        
        let tempStr = String(format: "%.\(number)f", self)
        let largeNumber = Double(tempStr.components(separatedBy: ".")[0])!
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber)) {
            if tempStr.components(separatedBy: ".").count > 1 {
                return formattedNumber + "." + tempStr.components(separatedBy: ".")[1]
            } else {
                return formattedNumber
            }
        }
        
        return "nil_Decimal"
        
    }
    
}
