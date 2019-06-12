//
//  SWFWorkUIViewController.swift
//  eCardio
//
//  Created by MacBook Pro on 9/10/18.
//  Copyright © 2018 Wolves. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func postAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func postConfirmAlert(_ title: String, _ message: String, _ button0: String, _ button1: String, action0: (() -> Void)? = nil, action1: (() -> Void)? = nil, _ isDestructive: Bool) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if isDestructive {
            alert.addAction(UIAlertAction(title: button0, style: .cancel, handler: { (action: UIAlertAction!) in
                if action0 != nil {
                    action0!()
                }
            }))
            alert.addAction(UIAlertAction(title: button1, style: .destructive, handler: { (action: UIAlertAction!) in
                if action1 != nil {
                    action1!()
                }
            }))
        } else {
            alert.addAction(UIAlertAction(title: button1, style: .default, handler: { (action: UIAlertAction!) in
                if action1 != nil {
                    action1!()
                }
            }))
            alert.addAction(UIAlertAction(title: button0, style: .cancel, handler: { (action: UIAlertAction!) in
                if action0 != nil {
                    action0!()
                }
            }))
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func postAlertAction(_ title: String, _ message: String, _ buttonTitel: String, doAction: (() -> Void)? = nil, _ btnStyle: UIAlertAction.Style) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: buttonTitel, style: btnStyle, handler: { (action: UIAlertAction!) in
            if doAction != nil {
                doAction!()
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 200, y: self.view.frame.size.height-100, width: 400, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
        
    }
    
    func showActivityIndicatory() {
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.view.frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.backgroundColor = .darkGray
        blurEffectView.contentView.backgroundColor = .darkGray
        blurEffectView.alpha = 0.0
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.addShadow(color: .gray, opacity: 1.0, radius: 1.0)
        actInd.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
        actInd.hidesWhenStopped = true
        actInd.style = .gray
        
        blurEffectView.contentView.addSubview(actInd)
        actInd.startAnimating()
        
        self.view.addSubview(blurEffectView)
        
    }
    
    func dimissActivityIndicatory() {
        
        for tempView in self.view.subviews {
            
            if tempView is UIVisualEffectView {
                tempView.removeFromSuperview()
            }
            
        }
        
    }
    
    func setNavbar(){
        
        navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font: UIFont(name: "Kanit-Medium", size: 15)!]
        
    }
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}

extension UIApplication {
    
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
    
}
