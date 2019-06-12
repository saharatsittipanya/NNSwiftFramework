//
//  NNFWorkConstraint.swift
//  Surprise Rayong
//
//  Created by Saharat Sittipanya on 7/12/61.
//  Copyright © พ.ศ. 2561 Wolves Corporation. All rights reserved.
//

import Foundation
import UIKit

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
let XD_width = CGFloat(360.0)
let XD_height = CGFloat(640.0)
let CurrentScreen_width = CGFloat(375.0)
let CurrentScreen_height = CGFloat(667.0)

@IBDesignable
class IPhoneHeaderFitConstraint: NSLayoutConstraint {
    
    @IBInspectable
    var doFitAllScreen:Bool = false {
        didSet {
            if doFitAllScreen { self.constant = calHeightForAllScreen(height: self.constant) }
        }
    }
    
    override func awakeFromNib() {
        if doFitAllScreen { self.constant = calHeightForAllScreen(height: self.constant) }
        self.constant += getIPhone() == "iPhone XS" || getIPhone() == "iPhone XS Max" ? 30:0
    }
}

@IBDesignable
class IPhoneFooterFitConstraint: NSLayoutConstraint {
    
    @IBInspectable
    var doFitAllScreen:Bool = false {
        didSet {
            if doFitAllScreen { self.constant = calHeightForAllScreen(height: self.constant) }
        }
    }
    
    override func awakeFromNib() {
        if doFitAllScreen { self.constant = calHeightForAllScreen(height: self.constant) }
        if getIPhone() == "iPhone XS" || getIPhone() == "iPhone XS Max" {
            self.constant += 25
        }
    }
}

@IBDesignable
class aspectRatioConstraint: NSLayoutConstraint {
    
    @IBInspectable
    var withScreen:String = "" {
        didSet {
            updateConstraint()
        }
    }
    
    @IBInspectable
    var withHeader:Bool = false {
        didSet {
            updateConstraint()
        }
    }
    
    @IBInspectable
    var withFooter:Bool = false {
        didSet {
            updateConstraint()
        }
    }
    
    @IBInspectable
    var aspectConstraint:CGFloat = 0.0 {
        didSet {
            updateConstraint()
        }
    }
    
    override func awakeFromNib() {
        updateConstraint()
    }
    
    func updateConstraint() {
        var aspectConstraint_New = aspectConstraint
        let isIPhoneXS = getIPhone() == "iPhone XS" || getIPhone() == "iPhone XS Max"
        let isIPhoneXR = getIPhone() == "iPhone XR"
        if withScreen == "width" { aspectConstraint_New = calWidthForAllScreen(width: aspectConstraint_New) }
        if withScreen == "height" { aspectConstraint_New = calHeightForAllScreen(height: aspectConstraint_New) }
        if withHeader && isIPhoneXS { aspectConstraint_New += 30 }
        if withHeader && isIPhoneXR { aspectConstraint_New += 35 }
        if withFooter && (isIPhoneXS || isIPhoneXR) { aspectConstraint_New += 25 }
        self.constant *= aspectConstraint_New/aspectConstraint
    }
}

class setWidthForAllScreen: NSLayoutConstraint {
    override func awakeFromNib() {
        self.constant = calWidthForAllScreen(width: self.constant)
    }
}

class setHeightForAllScreen: NSLayoutConstraint {
    override func awakeFromNib() {
        self.constant = calHeightForAllScreen(height: self.constant)
    }
}

class XDWidthConstraint: NSLayoutConstraint {
    override func awakeFromNib() {
        self.constant = setWidthFromXDRatio(width: self.constant)
    }
}

class XDHeightConstraint: NSLayoutConstraint {
    override func awakeFromNib() {
        self.constant = setHeightFromXDRatio(height: self.constant)
    }
}

class FitHeightToScreen: NSLayoutConstraint {
    override func awakeFromNib() {
        self.constant = screenHeight
    }
}

class FitWidthToScreen: NSLayoutConstraint {
    override func awakeFromNib() {
        self.constant = screenWidth
    }
}

func setWidthFromXDRatio(width : CGFloat) -> CGFloat {
    return width * screenWidth / XD_width
}

func setHeightFromXDRatio(height : CGFloat) -> CGFloat {
    return height * screenHeight / XD_height
}

func calWidthForAllScreen(width : CGFloat) -> CGFloat {
    return width * screenWidth/CurrentScreen_width
}

func calHeightForAllScreen(height : CGFloat) -> CGFloat {
    return height * screenHeight/CurrentScreen_height
}

func constrainTransition(_ con: NSLayoutConstraint, _ toContrain: Float, _ duration: Float, Completion: @escaping (Bool) -> Void = { (BOOL) in }) {
    
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
