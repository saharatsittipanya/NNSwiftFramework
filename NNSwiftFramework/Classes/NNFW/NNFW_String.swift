//
//  NNFW_String.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import UIKit

extension String {
    
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
        
    }

    public func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
        
    }
    
    public func copyToClipboard() {
        
        UIPasteboard.general.string = self
        
    }
    
    public func replace(target: String, withString: String) -> String {
        
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
        
    }
    
    public func trimmingStrings(in set: [String]) -> String {
        
        var resultSTR = self
        
        for STR in set {
            resultSTR = resultSTR.replace(target: STR, withString: "")
        }
        
        return resultSTR
        
    }
    
    public var hexColor: UIColor {
        
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
    
    public func characterAtIndex(index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur++
        }
        return nil
    }
    
    public func addCommas(Decimal number: Int = 0) -> String {
        
        if let DoubleValue = Double(self) {
            
            let tempStr = String(format: "%.\(number)f", DoubleValue)
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
            
        } else {
            
            return "0"
            
        }
        
    }
    
    public func addCommasSpecial(Decimal number: Int = 0) -> String {
        
        if let DoubleValue = Double(self) {
            
            let tempStr = String(format: "%.\(number)f", DoubleValue)
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
            
        } else {
            
            return "0"
            
        }
        
    }
    
}
