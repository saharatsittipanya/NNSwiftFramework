//
//  SWFWorkDate.swift
//  eCardio
//
//  Created by MacBook Pro on 9/13/18.
//  Copyright © 2018 Wolves. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func getStrTimeFromFormat(format: String ) -> String{
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        dateFormatterPrint.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatterPrint.string(from: self)
    }
    
    func getStrDateFromFormat(format: String , yearType:Int) -> String{
        // yearType = 0 -> พุธ
        // yearType = 1 -> คริส
        var temp_date = self
        if yearType == 1 {
            let formatteryear = DateFormatter()
            formatteryear.dateFormat = "yyyy"
            let year = Int(formatteryear.string(from: self))!
            if year > 2400 {
                temp_date = temp_date.setyear!
            }
        } else {
            let formatteryear = DateFormatter()
            formatteryear.dateFormat = "yyyy"
            let year = Int(formatteryear.string(from: self))!
            if year < 2400 {
                temp_date = temp_date.setyear2!
            }
        }
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        
        return dateFormatterPrint.string(from: temp_date)
    }
    
    var setyear: Date? {
        return Calendar.current.date(byAdding: .year, value: -543, to: self)
    }
    
    var setyear2: Date? {
        return Calendar.current.date(byAdding: .year, value: -543, to: self)
    }
    
    func setYear(format: Int) -> Date{
        return Calendar.current.date(byAdding: .year, value: format, to: self)!
    }
}
