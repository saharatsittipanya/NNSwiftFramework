//
//  NNFWorkFunction.swift
//  MEECHOKE
//
//  Created by Saharat Sittipanya on 26/11/61.
//  Copyright © พ.ศ. 2561 Wolves Corporation. All rights reserved.
//

import Foundation
import UIKit

func getIPhoneName() -> String{
    return UIDevice.current.name
}

func getCurrencyFormatFromNumber(number: Double) -> String {
    let formatter = NumberFormatter()
    formatter.locale = Locale.current
    formatter.numberStyle = .currency
    if var formattedCurrency = formatter.string(from: number as NSNumber) {
        formattedCurrency = formattedCurrency.components(separatedBy: "$")[1]
        return formattedCurrency
    } else {
        return ""
    }
}

func getAbbreviationProvince(province:String, haveDot:Bool) -> String {
    let FullProvinces = "กระบี่,กบ,KBI|กรุงเทพมหานคร,กทม,BKK|กาญจนบุรี,กจ,KRI|กาฬสินธุ์,กส,KSN|กำแพงเพชร,กพ,KPT|ขอนแก่น,ขก,KKN|จันทบุรี,จบ,CTI|ฉะเชิงเทรา,ฉช,CCO|ชลบุรี,ชบ,CBI|ชัยนาท,ชน,CNT|ชัยภูมิ,ชย,CPM|ชุมพร,ชพ,CPN|เชียงราย,ชร,CRI|เชียงใหม่,ชม,CMI|ตรัง,ตง,TRG|ตราด,ตร,TRT|ตาก,ตก,TAK|นครนายก,นย,NYK|นครปฐม,นฐ,NPT|นครพนม,นพ,NPM|นครราชสีมา,นม,NMA|นครศรีธรรมราช,นศ,NRT|นครสวรรค์,นว,NSN|นนทบุรี,นบ,NBI|นราธิวาส,นธ,NWT|น่าน,นน,NAN|บึงกาฬ,บก,BKN|บุรีรัมย์,บร,BRM|ปทุมธานี,ปท,PTE|ประจวบคีรีขันธ์,ปข,PKN|ปราจีนบุรี,ปจ,PRI|ปัตตานี,ปน,PTN|พะเยา,พย,PYO|พระนครศรีอยุธยา,อย,AYA|พังงา,พง,PNA|พัทลุง,พท,PLG|พิจิตร,พจ,PCK|พิษณุโลก,พล,PLK|เพชรบุรี,พบ,PBI|เพชรบูรณ์,พช,PNB|แพร่,พร,PRE|ภูเก็ต,ภก,PKT|มหาสารคาม,มค,MKM|มุกดาหาร,มห,MDH|แม่ฮ่องสอน,มส,MSN|ยโสธร,ยส,YST|ยะลา,ยล,YLA|ร้อยเอ็ด,รอ,RET|ระนอง,รน,RNG|ระยอง,รย,RYG|ราชบุรี,รบ,RBR|ลพบุรี,ลบ,LRI|ลำปาง,ลป,LPG|ลำพูน,ลพ,LPN|เลย,ลย,LEI|ศรีสะเกษ,ศก,SSK|สกลนคร,สน,SNK|สงขลา,สข,SKA|สตูล,สต,STN|สมุทรปราการ,สป,SPK|สมุทรสงคราม,สส,SKM|สมุทรสาคร,สค,SKN|สระแก้ว,สก,SKW|สระบุรี,สบ,SRI|สิงห์บุรี,สห,SBR|สุโขทัย,สท,STI|สุพรรณบุรี,สพ,SPB|สุราษฎร์ธานี,สฎ,SNI|สุรินทร์,สร,SRN|หนองคาย,นค,NKI|หนองบัวลำภู,นภ,NBP|อ่างทอง,อท,ATG|อำนาจเจริญ,อจ,ACR|อุดรธานี,อด,UDN|อุตรดิตถ์,อต,UTT|อุทัยธานี,อน,UTI|อุบลราชธานี,อบ,UBN"
    let oneProvince = FullProvinces.components(separatedBy: "|")
    for tempProvince in oneProvince {
        if tempProvince.components(separatedBy: ",")[0] == province {
            return haveDot ? "\(tempProvince.components(separatedBy: ",")[1]).":tempProvince.components(separatedBy: ",")[1]
        }
    }
    return ""
}

func alphaChange(with view: UIView, to alpha: CGFloat, in duration: TimeInterval, completion: @escaping (Bool) -> Void = { (BOOL) in }) {
    
    UIView.animate(withDuration: duration, animations: {
        
        view.alpha = alpha
        view.layoutIfNeeded()
        
    }, completion: { (Bool) in
        
        completion(Bool)
        
    })
    
}

func showView(with view: UIView, in duration: TimeInterval) {
    
    UIView.animate(withDuration: duration, delay: 0, options: .transitionFlipFromTop, animations: {
        view.alpha = 1
    }, completion: nil)
    
}
