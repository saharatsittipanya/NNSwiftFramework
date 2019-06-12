//
//  NNFWorkDate.swift
//  Surprise Rayong
//
//  Created by Saharat Sittipanya on 14/1/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import Foundation

extension Date {
    
    func getElapsedInterval(to end: Date = Date()) -> String {
        
        if let interval = Calendar.current.dateComponents([Calendar.Component.year], from: self, to: end).day {
            if interval > 0 {
                return "\(interval) yr\(interval == 1 ? "":"s")."
            }
        }
        
        if let interval = Calendar.current.dateComponents([Calendar.Component.month], from: self, to: end).month {
            if interval > 0 {
                return "\(interval) mth\(interval == 1 ? "":"s")."
            }
        }
        
        if let interval = Calendar.current.dateComponents([Calendar.Component.weekOfMonth], from: self, to: end).weekOfMonth {
            if interval > 0 {
                return "\(interval) wk\(interval == 1 ? "":"s")."
            }
        }
        
        if let interval = Calendar.current.dateComponents([Calendar.Component.day], from: self, to: end).day {
            if interval > 0 {
                return "\(interval) day\(interval == 1 ? "":"s")"
            }
        }
        
        if let interval = Calendar.current.dateComponents([Calendar.Component.hour], from: self, to: end).hour {
            if interval > 0 {
                return "\(interval) hr\(interval == 1 ? "":"s")."
            }
        }
        
        if let interval = Calendar.current.dateComponents([Calendar.Component.minute], from: self, to: end).minute {
            if interval > 0 {
                return "\(interval) min\(interval == 1 ? "":"s")."
            }
        }
        
        return "Just now."
    }
    
    func getCountLeftDay(to end: Date = Date()) -> Int {
        
        if let interval = Calendar.current.dateComponents([Calendar.Component.day], from: end, to: self).day {
            if interval > 0 {
                return interval
            }
        }
        
        return 0
        
    }
    
    var tomorrow: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }
    
    var plus7hour: Date? {
        return Calendar.current.date(byAdding: .hour, value: 7, to: self)
    }
    
}

extension String {
    
    func getAgeInYears(fromFormat: String = "yyyy-MM-dd") -> Int? {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = fromFormat
        
        if let dateNow = dateFormatter.date(from: dateFormatter.string(from: Date())),
            let birthDate = dateFormatter.date(from: self) {
            
            if let interval = Calendar.current.dateComponents([Calendar.Component.year], from: birthDate, to: dateNow).year {
                
                if interval >= 0 {
                    
                    return interval
                    
                }
                
            }
            
        }
        
        return nil
        
    }
    
}

func getDateTime(from Str: String, format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: Str)!
    
}

func getDateTimeStrFrom(format: String = "yyyy/MM/dd HH:mm:ss", isPorSor: Bool = false) -> String {
    
    let formatter = DateFormatter()
    
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = format
    
    return formatter.string(from: isPorSor ? replaceKorSorToPorSor(date: Date()) : Date())
    
}

func getDateTimeStrFromDate(format: String, date: Date) -> String {
    if format != "" {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    } else {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: date)
    }
}

func getDateTimeFormatFromString(formatTo:String , formatFrom:String , dateFrom:String) -> String {
    let formatterfrom = DateFormatter()
    formatterfrom.locale = Locale(identifier: "en_US")
    formatterfrom.dateFormat = formatFrom
    
    let formatterTo = DateFormatter()
    formatterTo.locale = Locale(identifier: "en_US")
    formatterTo.dateFormat = formatTo
    
    let reuslt = formatterTo.string(from: formatterfrom.date(from: dateFrom)!)
    return reuslt
}



func replacePorSorToKorSor(date: String) -> String {
    var tempStr = ""
    var tempArr = date.components(separatedBy: "-")
    for i in 0..<tempArr.count {
        if i > 0 {
            if i > 1 {
                tempStr += "-"
            }
            tempStr += tempArr[i]
        }
    }
    var intYear = Int(date.components(separatedBy: "-")[0])
    if intYear! > 2500 { intYear! -= 543 }
    return "\(intYear!)-\(tempStr)"
}

func replacePorSorToKorSor(date: Date) -> Date {
    let dateString = getDateTimeStrFromDate(format: "", date: date)
    var tempStr = ""
    var tempArr = dateString.components(separatedBy: "/")
    for i in 0..<tempArr.count {
        if i > 0 {
            if i > 1 {
                tempStr += "/"
            }
            tempStr += tempArr[i]
        }
    }
    var intYear = Int(dateString.components(separatedBy: "/")[0])
    if intYear! > 2500 { intYear! -= 543 }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.date(from: "\(intYear!)/\(tempStr)")!
}

func replaceKorSorToPorSor(date: String) -> String {
    var tempStr = ""
    var tempArr = date.components(separatedBy: "-")
    for i in 0..<tempArr.count {
        if i > 0 {
            if i > 1 {
                tempStr += "-"
            }
            tempStr += tempArr[i]
        }
    }
    var intYear = Int(date.components(separatedBy: "-")[0])
    if intYear! < 2500 { intYear! += 543 }
    return "\(intYear!)-\(tempStr)"
}

func replaceKorSorToPorSor(date: Date) -> Date {
    let dateString = getDateTimeStrFromDate(format: "", date: date)
    var tempStr = ""
    var tempArr = dateString.components(separatedBy: "/")
    for i in 0..<tempArr.count {
        if i > 0 {
            if i > 1 {
                tempStr += "/"
            }
            tempStr += tempArr[i]
        }
    }
    var intYear = Int(dateString.components(separatedBy: "/")[0])
    if intYear! < 2500 { intYear! += 543 }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.date(from: "\(intYear!)/\(tempStr)")!
}

func replaceFixYear(date: Date) -> Date {
    
    let dateString = getDateTimeStrFromDate(format: "", date: date)
    
    var tempStr = ""
    var tempArr = dateString.components(separatedBy: "/")
    for i in 0..<tempArr.count {
        if i > 0 {
            if i > 1 {
                tempStr += "/"
            }
            tempStr += tempArr[i]
        }
    }
    var intYear = Int(dateString.components(separatedBy: "/")[0])
    if intYear! < 1500 { intYear! += 543 }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return dateFormatter.date(from: "\(intYear!)/\(tempStr)")!
    
}

func getTimeStrFromMinuteNumber(minute:Int) -> String {
    if minute >= 1440 {
        let day = minute/1440
        let hour = minute%1440/60
        let min = minute%1440%60
        return "\(day) วัน \(hour) ชั่วโมง \(min) นาที"
    } else if minute >= 60 {
        let hour = minute%1440/60
        let min = minute%1440%60
        return "\(hour) ชั่วโมง \(min) นาที"
    } else {
        return "\(minute) นาที"
    }
}

func getTimerStrFromSecond(second: Int) -> String {
    if second >= 3600 {
        let hour = second/3600
        let min = second%3600/60
        let sec = second%3600%60
        return "\(hour < 10 ? "0":"")\(hour):\(min < 10 ? "0":"")\(min):\(sec < 10 ? "0":"")\(sec)"
    } else {
        if second >= 60 {
            let min = second/60
            let sec = second%60
            return "\(min < 10 ? "0":"")\(min):\(sec < 10 ? "0":"")\(sec)"
        } else {
            return "00:\(second < 10 ? "0":"")\(second)"
        }
    }
}
