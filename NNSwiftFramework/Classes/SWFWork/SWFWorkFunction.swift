//
//  SWFWorkFunction.swift
//  eCardio
//
//  Created by MacBook Pro on 9/10/18.
//  Copyright © 2018 Wolves. All rights reserved.
//

import Foundation
import UIKit

func getIPhone() -> String{
    switch screenHeight {
    case 480:
        return "4s"
    case 568:
        return "SE"
    case 667:
        return "8"
    case 736:
        return "8Plus"
    case 812:
        return "iPhone XS"
    case 896:
        return "iPhone XS Max"
    case 1024:
        return "Pro9.7"
    case 1112:
        return "Pro10.5"
    case 1194:
        return "Pro11"
    case 1366:
        return "Pro12.9"
    default:
        return "nil"
    }
}

func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    image.draw(in: CGRect(x: 0,y: 0,width: newWidth,height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}

func getHightFromWidth(image: UIImage, newWidth: CGFloat) -> CGFloat {
    let scale = newWidth / image.size.width
    let newHeight = image.size.height * scale
    UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
    return newHeight
}

func generateQRCode(from string: String) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 3, y: 3)
        
        if let output = filter.outputImage?.transformed(by: transform) {
            return UIImage(ciImage: output)
        }
    }
    return nil
}


func calculateAge(birthday: String) -> Int {
    
    let dateFormater = DateFormatter()
    dateFormater.dateFormat = "yyyy-MM-dd"
    let birthdayDate = dateFormater.date(from: birthday)
    let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
    let now = Date()
    
    var calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
    let formatteryear = DateFormatter()
    formatteryear.dateFormat = "yyyy"
    let year = Int(formatteryear.string(from: now))!
    if year > 2400 {
        calcAge = calendar.components(.year, from: birthdayDate!, to: now.setyear!, options: [])
    }
    
    let age = calcAge.year
    return age!
    
}


var roomArray: [String] {
    get {
        return UserDefaults.standard.array(forKey: "roomArray") as? [String] ?? []
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "roomArray")
    }
}


var buildingArray: [String] {
    get {
        return UserDefaults.standard.array(forKey: "buildingArray") as? [String] ?? []
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "buildingArray")
    }
}

var floorArray: [String] {
    get {
        return UserDefaults.standard.array(forKey: "floorArray") as? [String] ?? []
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "floorArray")
    }
}


precedencegroup ExponentiationPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator ^^: ExponentiationPrecedence
public func ^^ (radix: Float, power: Float) -> Float {
    return pow((radix), (power))
}

public func ^^ (radix: Double, power: Double) -> Double {
    return pow((radix), (power))
}

public func ^^ (radix: Int, power: Int) -> Int {
    return NSDecimalNumber(decimal: pow(Decimal(radix), power)).intValue
}

