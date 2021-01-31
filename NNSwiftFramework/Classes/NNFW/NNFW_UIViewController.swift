//
//  NNFW_UIViewController.swift
//
//  Created by Saharat Sittipanya on 22/5/2563 BE.
//

import UIKit
import SafariServices

extension UIViewController {
    
    public func postAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    public func postConfirmAlert(_ title: String, _ message: String, _ button0: String, _ button1: String, action0: (() -> Void)? = nil, action1: (() -> Void)? = nil, _ isDestructive: Bool) {
        
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
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    public func postAlertAction(_ title: String, _ message: String, _ buttonTitel: String, doAction: (() -> Void)? = nil, _ btnStyle: UIAlertAction.Style) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: buttonTitel, style: btnStyle, handler: { (action: UIAlertAction!) in
            if doAction != nil {
                doAction!()
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    public func postActionSheet (
        withTitle title: String?,
        Message message: String?,
        _ buttonTitles: [String],
        _ buttonStyles: [UIAlertAction.Style],
        _ buttonActions: [((UIAlertAction) -> Void)?]
    ) {
        
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for i in 0..<buttonTitles.count {
            
            let alertAction = UIAlertAction(title: buttonTitles[i], style: buttonStyles[i], handler: buttonActions[i])
            
            alertViewController.addAction(alertAction)
            
        }
        
        self.present(alertViewController, animated: true, completion: nil)
        
    }
    
    public func showToast(message : String) {
        
        var font = UIFont(name: "Prompt-Regular", size: 12.0)
        if font == nil {
            font = UIFont(name: "HelveticaNeue-Regular", size: 12.0)
        }
        if font == nil {
            font = UIFont(name: "Helvetica Neue-Regular", size: 12.0)
        }
        if font == nil {
            font = UIFont(name: "Helvetica-Regular", size: 12.0)
        }
        if font == nil {
            font = UIFont(name: "System-Regular", size: 12.0)
        }
        guard let fontUse = font else {
            return
        }
        
        let width = self.view.frame.size.width - 60.0

        let height = ceil(message.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: fontUse], context: nil).height)
        
        let toastLabel = UILabel(frame: CGRect(x: (self.view.frame.size.width/2.0) - (width/2), y: self.view.frame.size.height-70.0-height, width: width, height: height))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = .white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 12.0)
        toastLabel.text = message
        toastLabel.numberOfLines = 0
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
    
    public func share(_ content: [Any]) {
        
        let activityViewController = UIActivityViewController(activityItems: content, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    public func openSafariWebview(withURL url: String) {
        
        if let URL_STR = URL(string: url) {
            
            let VC = SFSafariViewController(url: URL_STR)
            VC.modalPresentationStyle = .fullScreen
            
            self.present(VC, animated: true, completion: nil)
            
        }
        
    }

}
