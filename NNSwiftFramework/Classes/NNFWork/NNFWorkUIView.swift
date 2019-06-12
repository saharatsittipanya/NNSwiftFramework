//
//  NNFWorkUIView.swift
//  4SCTF
//
//  Created by Saharat Sittipanya on 6/3/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var parentViewController: UIViewController? {
        
        var parentResponder: UIResponder? = self
        
        while parentResponder != nil {
            
            parentResponder = parentResponder!.next
            
            if let viewController = parentResponder as? UIViewController {
                
                return viewController
                
            }
            
        }
        
        return nil
        
    }
    
    func viewCapture() -> UIImage? {
        
        UIGraphicsBeginImageContext(self.frame.size)
        
        guard let cgContext = UIGraphicsGetCurrentContext() else {
            print("Fail to get CGContext")
            return nil
        }
        self.layer.render(in: cgContext)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            print("Fail to get Image from current image context")
            return nil
        }
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
    func rotateWithAnimation(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        self.layer.add(animation, forKey: nil)
        
    }
    
    func getTextfield(view: UIView) -> [UITextField] {
        
        var results = [UITextField]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                results += [textField]
            } else {
                results += getTextfield(view: subview)
            }
        }
        return results
        
    }
    
    func getLabel(view: UIView) -> [UILabel] {
        
        var results = [UILabel]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UILabel {
                results += [textField]
            } else {
                results += getLabel(view: subview)
            }
        }
        return results
        
    }
    
    func isValidatedTextField() -> Bool {
        
        for textField in self.getTextfield(view: self) {
            
            if textField.text! == "" {
                
                self.parentViewController?.postAlert(APP_NAME, message: "กรุณากรอกข้อมูลให้ครบถ้วน")
                
                return false
                
            }
            
            if let NNTextField = textField as? validatedTextField {
                
                if !NNTextField.validatingMinSize() {
                    
                    self.parentViewController?.postAlert(APP_NAME, message: "กรุณากรอกข้อมูลให้ถูกต้อง")
                    
                    return false
                    
                }
                
            }
            
        }
        
        return true
        
    }
    
}

@IBDesignable
class NNRotatingView: UIView {
    
    @IBInspectable var RotateDegree: CGFloat = 0 {
        didSet {
            
            self.rotatingView()
            
        }
    }
    
    @IBInspectable var isClockwise: Bool = true {
        didSet {
            
            self.rotatingView()
            
        }
    }
    
    func rotatingView() {
        
        let Degree = self.RotateDegree < 0.0 ? 0.0 : self.RotateDegree > 180.0 ? 180 : self.RotateDegree
        
        let Radians = self.isClockwise ? CGFloat.pi * Degree / 180.0 : -CGFloat.pi * Degree / 180.0
        
        self.transform = CGAffineTransform(rotationAngle: Radians)
        
    }
    
}
