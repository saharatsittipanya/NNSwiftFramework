//
//  NNFW_Double.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import Foundation

extension Double {
    
    public func addCommas(Decimal number: Int) -> String {
        
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
        } else {
            
            return "0"
            
        }
        
    }
    
    public func addCommasSpecial(Decimal number: Int) -> String {
        
        let tempStr = String(format: "%.\(number)f", self)
        let largeNumber = Double(tempStr.components(separatedBy: ".")[0])!
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .decimal
        
        if let formattedNumber = numberFormatter.string(from: NSNumber(value:largeNumber)) {
            
            if tempStr.components(separatedBy: ".").count > 1 {
                
                let resultSTR = formattedNumber + "." + tempStr.components(separatedBy: ".")[1]
                
                if (Float(resultSTR.replace(target: ",", withString: "")) ?? 0.0).truncatingRemainder(dividingBy: 1.0) != 0.0 {
                    
                    return resultSTR.replace(target: ",", withString: "").addCommas(Decimal: number)
                    
                } else {
                    
                    return resultSTR.replace(target: ",", withString: "").addCommas(Decimal: 0)
                    
                }
                
            } else {
                
                let resultSTR = formattedNumber
                
                if (Float(resultSTR.replace(target: ",", withString: "")) ?? 0.0).truncatingRemainder(dividingBy: 1.0) != 0.0 {
                    
                    return resultSTR.replace(target: ",", withString: "").addCommas(Decimal: number)
                    
                } else {
                    
                    return resultSTR.replace(target: ",", withString: "").addCommas(Decimal: 0)
                    
                }
                
            }
            
        } else {
            
            return "0"
            
        }
        
    }
    
}
