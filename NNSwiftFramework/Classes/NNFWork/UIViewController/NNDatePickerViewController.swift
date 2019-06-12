//
//  NNDatePickerViewController.swift
//  4SCTF
//
//  Created by Saharat Sittipanya on 30/4/2562 BE.
//  Copyright © 2562 Wolves Corporation. All rights reserved.
//

import UIKit

class NNDatePickerViewController: UIViewController {

    var datePickerMode = UIDatePicker.Mode.date
    
    var resultFormet = "yyyy-MM-dd"
    
    var didSelectDate: (String) -> Void = { (_) in }
    
    @IBOutlet weak var m_timePicker: UIDatePicker!
    
    @IBAction func actionOK(_ sender: UIButton) {
        
        let result = getDateTimeStrFromDate(format: self.resultFormet, date: self.m_timePicker.date)
        
        self.didSelectDate(result)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func actionCancle(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.m_timePicker.datePickerMode = self.datePickerMode
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        alphaChange(with: self.view, to: 1.0, in: 0.4)
        
    }

}
