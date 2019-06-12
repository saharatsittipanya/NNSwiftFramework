//
//  SWFWorkUIView.swift
//  eCardio
//
//  Created by MacBook Pro on 9/10/18.
//  Copyright © 2018 Wolves. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class SWPrettyButton: UIButton {
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 5.0 {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }

    @IBInspectable var shadowRadius: CGFloat = CGFloat(5.0) {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
//    @IBInspectable var cornerRadius: CGFloat = 5 {
//        didSet {
//            self.layer.cornerRadius = cornerRadius
//            self.layer.masksToBounds = true
//        }
//    }
    
    @IBInspectable var cornerRadiusxd: CGFloat = 5 {
        didSet {
            self.layer.cornerRadius = setHeightFromXDRatio(height: cornerRadiusxd)/2
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = "#D6D6D6".hexColor {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var bgColor: String = "FFFFFF" {
        didSet {
            self.layer.backgroundColor = bgColor.hexColor.cgColor
        }
    }
}

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
//    @IBInspectable var shadowColor: CGColor {
//        get {
//            return layer.shadowColor!
//        }
//        set {
//            layer.shadowColor = newValue
//        }
//    }
//
//    @IBInspectable var shadowOpacity: CGColor {
//        get {
//            return layer.shadowColor!
//        }
//        set {
//            layer.shadowColor = newValue
//        }
//    }
//
//    @IBInspectable var shadowRadius: CGColor {
//        get {
//            return layer.shadowColor!
//        }
//        set {
//            layer.shadowColor = newValue
//        }
//    }
}

@IBDesignable
class SWPrettyView: UIView {
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 5.0 {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }

    @IBInspectable var shadowRadius: CGFloat = CGFloat(5.0) {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
//    @IBInspectable var cornerRadius: CGFloat = 5 {
//        didSet {
//            self.layer.cornerRadius = cornerRadius
//            self.layer.masksToBounds = true
//        }
//    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = "#D6D6D6".hexColor {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var bgColor: String = "FFFFFF" {
        didSet {
            self.layer.backgroundColor = bgColor.hexColor.cgColor
        }
    }
    
}

@IBDesignable
class SWPrettyImageView: UIImageView {
    
    @IBInspectable var isCircular: Bool = false {
        didSet {
            if isCircular {
                self.layer.cornerRadius = frame.height / 2
                self.layer.masksToBounds = true
            }
        }
    }
    
//    @IBInspectable var cornerRadius: CGFloat = 5 {
//        didSet {
//            self.layer.cornerRadius = cornerRadius
//            self.layer.masksToBounds = true
//        }
//    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = "#D6D6D6".hexColor {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var cornerRadiusxd: CGFloat = 5 {
        didSet {
            self.layer.cornerRadius = setHeightFromXDRatio(height: cornerRadiusxd)/2
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var isHorizontal: Bool = true {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map {$0.cgColor}
        if (isHorizontal) {
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0.5, y: 0)
            layer.endPoint = CGPoint (x: 0.5, y: 1)
        }
    }
    
//    @IBInspectable var cornerRadius: CGFloat = 5 {
//        didSet {
//            self.layer.cornerRadius = cornerRadius
//            self.layer.masksToBounds = true
//        }
//    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = "#D6D6D6".hexColor {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

@IBDesignable
class SWPrettyDropdown: UIPickerView {
    
    @IBInspectable var shadowColor: UIColor = UIColor.black {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 5.0 {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }

    @IBInspectable var shadowRadius: CGFloat = CGFloat(5.0) {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
//    @IBInspectable var cornerRadius: CGFloat = 5 {
//        didSet {
//            self.layer.cornerRadius = cornerRadius
//            self.layer.masksToBounds = true
//        }
//    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = "#D6D6D6".hexColor {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var bgColor: String = "FFFFFF" {
        didSet {
            self.layer.backgroundColor = bgColor.hexColor.cgColor
        }
    }
}

extension UIView {
    
    func addDashedBorder() {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func addBorder(color: UIColor , width: CGFloat){
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func addShadow(color: UIColor , opacity: Float , radius: CGFloat){
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = radius
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension SWPrettyButton {
    func toggle2ClearBG() {
        self.layer.backgroundColor = self.layer.backgroundColor == UIColor.clear.cgColor ? bgColor.hexColor.cgColor:UIColor.clear.cgColor
    }
}

@IBDesignable
class NNCustomSlider: UISlider {
    
    @IBInspectable var RotationDegree: Double = 0.0 {
        didSet {
            if RotationDegree >= -360 && RotationDegree <= 360 {
                let radiant = 360 / RotationDegree / 2
                transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / radiant))
            }
        }
    }
    
    @IBInspectable var trackHeight: CGFloat = 2
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: CGPoint(x: bounds.minX, y: bounds.minY), size: CGSize(width: bounds.width, height: trackHeight))
    }
    
}
