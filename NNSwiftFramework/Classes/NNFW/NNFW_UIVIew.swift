//
//  NNFW_UIVIew.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import UIKit

extension UIView {
    
    public var parentViewController: UIViewController? {
        
        var parentResponder: UIResponder? = self
        
        while parentResponder != nil {
            
            parentResponder = parentResponder!.next
            
            if let viewController = parentResponder as? UIViewController {
                
                return viewController
                
            }
            
        }
        
        return nil
        
    }
    
    public func captureContent() -> UIImage? {
        
        let bounds = self.bounds
        
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        guard let cgContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        cgContext.saveGState()
        
        self.layer.render(in: cgContext)
        
        guard let capturedImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        
        cgContext.restoreGState();
        UIGraphicsEndImageContext()
        
        return capturedImage
    }
    
    public func rotateWithAnimation(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.layer.add(animation, forKey: nil)
        
    }
    
    public func createDottedLine(width: CGFloat, color: CGColor) {
        
        let caShapeLayer = CAShapeLayer()
        caShapeLayer.strokeColor = color
        caShapeLayer.lineWidth = width
        caShapeLayer.lineDashPattern = [5,5]
        let cgPath = CGMutablePath()
        let cgPoint = [CGPoint(x: 0, y: 0), CGPoint(x: self.frame.width, y: 0)]
        cgPath.addLines(between: cgPoint)
        caShapeLayer.path = cgPath
        layer.addSublayer(caShapeLayer)
        
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
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
        layer.shadowOffset = CGSize(width: 0, height: 1)
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

@IBDesignable
public class NNCustomButton: UIButton {
    
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 5.0 {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = CGFloat(5.0) {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor = "#D6D6D6".hexColor {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var bgColor: String = "FFFFFF" {
        didSet {
            self.layer.backgroundColor = bgColor.hexColor.cgColor
        }
    }
}

@IBDesignable
public class NNCustomView: UIView {
    
    @IBInspectable public var isCircular: Bool = false {
        didSet {
            if isCircular {
                self.layer.cornerRadius = frame.height / 2
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable public var shadowColor: UIColor = UIColor.black {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
    @IBInspectable public var shadowOpacity: Float = 1.0 {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
    @IBInspectable public var shadowRadius: CGFloat = CGFloat(3.0) {
        didSet {
            addShadow(color: shadowColor, opacity: shadowOpacity, radius: shadowRadius)
        }
    }
    
    @IBInspectable public var shadowOffset: CGSize = CGSize(width: 0.0, height: 1.0) {
        didSet {
            
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOpacity = shadowOpacity
            layer.shadowOffset = shadowOffset
            layer.shadowRadius = shadowRadius
            layer.masksToBounds = false
            
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor = "#D6D6D6".hexColor {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var bgColor: String = "FFFFFF" {
        didSet {
            self.layer.backgroundColor = bgColor.hexColor.cgColor
        }
    }
    
}

@IBDesignable
public class NNGradientView: UIView {
    
    @IBInspectable public var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var isHorizontal: Bool = true {
        didSet {
            updateView()
        }
    }
    
    override public class var layerClass: AnyClass {
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
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor = "#D6D6D6".hexColor {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
