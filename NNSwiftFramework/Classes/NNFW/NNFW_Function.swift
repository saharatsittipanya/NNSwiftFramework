//
//  NNFW_Function.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import UIKit

public let screenSize = UIScreen.main.bounds
public let screenWidth = screenSize.width
public let screenHeight = screenSize.height

public func delay(in Time: TimeInterval, toDo Dofunc: @escaping () -> Void) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + Time) {
        Dofunc()
    }
    
}

public func getIPhoneName() -> String{
    return UIDevice.current.name
}

public func alphaChange(with view: UIView, to alpha: CGFloat, in duration: TimeInterval, completion: @escaping (Bool) -> Void = { (BOOL) in }) {
    
    UIView.animate(withDuration: duration, animations: {
        
        view.alpha = alpha
        view.layoutIfNeeded()
        
    }, completion: { (Bool) in
        
        completion(Bool)
        
    })
    
}

public func constraintTransition(_ con: NSLayoutConstraint, _ toContrain: Float, _ duration: Float, Completion: @escaping (Bool) -> Void = { (BOOL) in }) {
    
    let interval: Float = 0.001
    let range = toContrain - Float(con.constant)
    let rangeInStep = range / (duration / interval)
    var splaceTimer: Timer?
    var tempDutation = duration - interval
    
    splaceTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(interval), repeats: true, block: { _ in
        
        if tempDutation > 0 {
            
            con.constant += CGFloat(rangeInStep)
            tempDutation -= interval
            
        } else {
            
            con.constant = CGFloat(toContrain)
            splaceTimer?.invalidate()
            
            Completion(true)
            
            return
            
        }
        
    })
    
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

public postfix func ++ (_ Radix: inout Int) {
    Radix += 1
}

public postfix func -- (_ Radix: inout Int) {
    Radix -= 1
}

infix operator ???

public func ??? (Source: String?, Replace: String) -> String {
    
    if Source == nil || Source == "" || Source?.replace(target: " ", withString: "") == "" {
        
        return Replace
        
    } else {
        
        return Source!
        
    }
    
}
