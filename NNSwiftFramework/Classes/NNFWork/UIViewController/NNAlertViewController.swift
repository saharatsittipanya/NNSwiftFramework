//
//  NNAlertViewController.swift
//  4SCTF
//
//  Created by Saharat Sittipanya on 30/4/2562 BE.
//  Copyright © 2562 Wolves Corporation. All rights reserved.
//

import UIKit

class NNAlertViewController: UIViewController {
    
    @IBOutlet weak var m_Title_Lbl: UILabel!
    @IBOutlet weak var m_Confirm_Btn: UIButton!
    @IBOutlet weak var m_Cancel_Btn: UIButton!
    
    var alertTitle = "Question?"
    var alertComfirmTitle = "ยืนยัน"
    var alertCancelTitle = "ยกเลิก"
    
    var onClick_Confirm: () -> Void = {}
    var onClick_Cancel: () -> Void = {}
    
    @IBAction func onClick_ConfirmBtn(_ sender: UIButton) {
        
        self.onClick_Confirm()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onClick_CancelBtn(_ sender: UIButton) {
        
        self.onClick_Cancel()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.m_Title_Lbl.text = self.alertTitle
        self.m_Confirm_Btn.setTitle(self.alertComfirmTitle, for: .normal)
        self.m_Cancel_Btn.setTitle(self.alertCancelTitle, for: .normal)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        alphaChange(with: self.view, to: 1.0, in: 0.2)
        alphaChange(with: self.view.subviews[0], to: 1.0, in: 0.3)
        
    }
    
}
