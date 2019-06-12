//
//  NNFWorkAPI.swift
//  SuandokMeeting
//
//  Created by Saharat Sittipanya on 5/4/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

let APP_NAME = "Rise Condo"
let FINAL_API_KEY = "2f150b5ab025334c2bf404b9730e591e"
let FINAL_API_URL = "http://wolves-test.com/risecondo/system/api/main/call.php"
let FINAL_CODE_USER = "anrmb"
let FINAL_CODE_RISECONDO = "errfr"
let FINAL_CODE_CONTENT = "ygdjm"

extension UIViewController {
    
    func connect_API(_ paramData: [String : Any], completionHandler: @escaping (_ result: JSON) -> Void) {
        
        self.showActivityIndicatory()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        manager.request(FINAL_API_URL, method: .post, parameters: paramData)
            .downloadProgress { progress in
            }
            .responseJSON() {
                response in
                self.dimissActivityIndicatory()
                switch (response.result) {
                case .success:
                    
                    do {
                        var temp_JSON: JSON = []
                        temp_JSON = try JSON(data: response.data!)
                        if temp_JSON["response_status"].bool == true {

                            completionHandler(temp_JSON["response_data"])
                            
                        } else {
                            self.postAlert(APP_NAME, message: "\(temp_JSON["response_message"].stringValue)")
                        }
                    }catch _ {
                        
                    }
                    
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        self.postAlert(APP_NAME, message: "Connect to server is time out.")
                    } else {
                        self.postAlert(APP_NAME, message: "Can't connect to server.")
                    }
                    break
                }
        }
        
    }
    
    func connect_API_Login(_ username: String, _ password: String, completionHandler: @escaping () -> Void) {
        
        if username == "" {
            
            self.showToast(message: "Please Input Username.")
            return
            
        }
        
        if password == "" {
            
            self.showToast(message: "Please Input Password.")
            return
            
        }
        
        self.showActivityIndicatory()
        
        let Data = [
            "apikey": FINAL_API_KEY,
            "code": FINAL_CODE_USER,
            "action": "login",
            "username": username,
            "password": password
        ]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        manager.request(FINAL_API_URL, method: .post, parameters: Data)
            .downloadProgress { progress in
            }
            .responseJSON() {
                response in
                self.dimissActivityIndicatory()
                switch (response.result) {
                case .success:
                    do {
                        var temp_JSON: JSON = []
                        temp_JSON = try JSON(data: response.data!)
                        if temp_JSON["response_status"].bool == true {
                            
                            UserDefaults.standard.set(response.data!, forKey: "UserDetail")
                            
                            completionHandler()
                            
                        } else {
                            self.postAlert(APP_NAME, message: "\(temp_JSON["response_message"].stringValue)")
                        }
                    }catch _ {
                        
                    }
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        self.postAlert(APP_NAME, message: "Connect to server is time out.")
                    } else {
                        self.postAlert(APP_NAME, message: "Can't connect to server.")
                    }
                    break
                }
        }
        
    }
    
    func connect_API_UserGetByID(completionHandler: @escaping () -> Void) {
        
        self.showActivityIndicatory()
        
        let Data = [
            "apikey": FINAL_API_KEY,
            "code": FINAL_CODE_USER,
            "action": "user_getbyid",
            "user_id": getUserDetail(formKey: "user_id")
        ]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        manager.request(FINAL_API_URL, method: .post, parameters: Data)
            .downloadProgress { progress in
            }
            .responseJSON() {
                response in
                self.dimissActivityIndicatory()
                switch (response.result) {
                case .success:
                    do {
                        var temp_JSON: JSON = []
                        temp_JSON = try JSON(data: response.data!)
                        if temp_JSON["response_status"].bool == true {
                            
                            UserDefaults.standard.set(response.data!, forKey: "UserDetail")
                            
                            completionHandler()
                            
                        } else {
                            self.postAlert(APP_NAME, message: "\(temp_JSON["response_message"].stringValue)")
                        }
                    }catch _ {
                        
                    }
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        self.postAlert(APP_NAME, message: "Connect to server is time out.")
                    } else {
                        self.postAlert(APP_NAME, message: "Can't connect to server.")
                    }
                    break
                }
        }
        
    }
    
    func connectAPI_Upload(_ image: UIImage, withKey Str: String = "image", _ paramData: [String : String], completionHandler: @escaping (JSON) -> Void) {
        
        let uploadProgress = UIProgressView()
        var uploadRequest: Request?
        
        let alertProgressController = UIAlertController(title: nil, message: "กำลังส่งข้อมูลโปรดรอ...\nอัพโหลดเสร็จแล้ว 0.0 %%", preferredStyle: .actionSheet)
        alertProgressController.view.addSubview(uploadProgress)
        
        let cancelUploadAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: { UIAlertAction in
            
            uploadRequest?.cancel()
            uploadRequest = nil
            alertProgressController.dismiss(animated: true, completion: {})
            
        })
        
        alertProgressController.addAction(cancelUploadAction)
        uploadProgress.frame = CGRect(x: 10, y: 50, width: screenWidth - 40, height: 10)
        self.present(alertProgressController, animated: true, completion: nil)
        
        let ImageData = image.pngData()
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(ImageData!, withName: Str,fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in paramData {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: FINAL_API_URL)
        { (result) in
            
            switch result {
                
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    uploadProgress.progress = Float(progress.fractionCompleted)
                    alertProgressController.message = String(format: "กำลังส่งข้อมูลโปรดรอ...\nอัพโหลดเสร็จแล้ว %.2f %%", progress.fractionCompleted * 100.0)
                })
                
                upload.responseJSON(completionHandler: { (response) in
                    
                    alertProgressController.dismiss(animated: true, completion: {})
                    
                    switch (response.result) {
                        
                    case .success:
                        
                        do {
                            var temp_JSON: JSON = []
                            temp_JSON = try JSON(data: response.data!)
                            if temp_JSON["response_status"].bool == true {
                                
                                completionHandler(temp_JSON["response_data"])
                                
                            } else {
                                self.showToast(message: "\(temp_JSON["response_message"].stringValue)")
                            }
                        }catch _ {
                            self.showToast(message: "Can't convert response to JSON.")
                        }
                        
                        break
                        
                    case .failure( _):
                        
                        self.showToast(message: "Can't connect to server")
                        
                        break
                    }
                })
                
            case .failure(let encodingError):
                
                alertProgressController.dismiss(animated: true, completion: {})
                if encodingError._code == NSURLErrorTimedOut {
                    self.postAlert(APP_NAME, message: "Connect to server is time out.")
                } else {
                    self.postAlert(APP_NAME, message: "Can't connect to server.")
                }
                
                break
                
            }
            
        }
    }
    
}

extension UIView {
    
    func connect_API(_ paramData: [String : Any], completionHandler: @escaping (_ result: JSON) -> Void) {
        
        self.parentViewController?.showActivityIndicatory()
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        manager.request(FINAL_API_URL, method: .post, parameters: paramData)
            .downloadProgress { progress in
            }
            .responseJSON() {
                response in
                self.parentViewController?.dimissActivityIndicatory()
                switch (response.result) {
                case .success:
                    
                    do {
                        var temp_JSON: JSON = []
                        temp_JSON = try JSON(data: response.data!)
                        if temp_JSON["response_status"].bool == true {
                            
                            completionHandler(temp_JSON["response_data"])
                            
                        } else {
                            self.parentViewController?.postAlert(APP_NAME, message: "\(temp_JSON["response_message"].stringValue)")
                        }
                    }catch _ {
                        
                    }
                    
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        self.parentViewController?.postAlert(APP_NAME, message: "Connect to server is time out.")
                    } else {
                        self.parentViewController?.postAlert(APP_NAME, message: "Can't connect to server.")
                    }
                    break
                }
        }
        
    }
    
    func connect_API_Login(_ username: String, _ password: String, completionHandler: @escaping () -> Void) {
        
        if username == "" {
            
            self.parentViewController?.showToast(message: "Please Input Username.")
            return
            
        }
        
        if password == "" {
            
            self.parentViewController?.showToast(message: "Please Input Password.")
            return
            
        }
        
        self.parentViewController?.showActivityIndicatory()
        
        let Data = [
            "apikey": FINAL_API_KEY,
            "code": FINAL_CODE_USER,
            "action": "login",
            "username": username,
            "password": password
        ]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        manager.request(FINAL_API_URL, method: .post, parameters: Data)
            .downloadProgress { progress in
            }
            .responseJSON() {
                response in
                self.parentViewController?.dimissActivityIndicatory()
                switch (response.result) {
                case .success:
                    do {
                        var temp_JSON: JSON = []
                        temp_JSON = try JSON(data: response.data!)
                        if temp_JSON["response_status"].bool == true {
                            
                            UserDefaults.standard.set(response.data!, forKey: "UserDetail")
                            
                            completionHandler()
                            
                        } else {
                            self.parentViewController?.postAlert(APP_NAME, message: "\(temp_JSON["response_message"].stringValue)")
                        }
                    }catch _ {
                        
                    }
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        self.parentViewController?.postAlert(APP_NAME, message: "Connect to server is time out.")
                    } else {
                        self.parentViewController?.postAlert(APP_NAME, message: "Can't connect to server.")
                    }
                    break
                }
        }
        
    }
    
    func connect_API_UserGetByID(completionHandler: @escaping () -> Void) {
        
        self.parentViewController?.showActivityIndicatory()
        
        let Data = [
            "apikey": FINAL_API_KEY,
            "code": FINAL_CODE_USER,
            "action": "user_getbyid",
            "user_id": UserDefaults.standard.string(forKey: "UserID")!
        ]
        
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        manager.request(FINAL_API_URL, method: .post, parameters: Data)
            .downloadProgress { progress in
            }
            .responseJSON() {
                response in
                self.parentViewController?.dimissActivityIndicatory()
                switch (response.result) {
                case .success:
                    do {
                        var temp_JSON: JSON = []
                        temp_JSON = try JSON(data: response.data!)
                        if temp_JSON["response_status"].bool == true {
                            
                            UserDefaults.standard.set(response.data!, forKey: "UserDetail")
                            
                            completionHandler()
                            
                        } else {
                            self.parentViewController?.postAlert(APP_NAME, message: "\(temp_JSON["response_message"].stringValue)")
                        }
                    }catch _ {
                        
                    }
                    break
                case .failure(let error):
                    if error._code == NSURLErrorTimedOut {
                        self.parentViewController?.postAlert(APP_NAME, message: "Connect to server is time out.")
                    } else {
                        self.parentViewController?.postAlert(APP_NAME, message: "Can't connect to server.")
                    }
                    break
                }
        }
        
    }
    
    func connectAPI_Upload(_ image: UIImage, withKey Str: String = "image", _ paramData: [String : String], completionHandler: @escaping (JSON) -> Void) {
        
        let uploadProgress = UIProgressView()
        var uploadRequest: Request?
        
        let alertProgressController = UIAlertController(title: nil, message: "กำลังส่งข้อมูลโปรดรอ...\nอัพโหลดเสร็จแล้ว 0.0 %%", preferredStyle: .actionSheet)
        alertProgressController.view.addSubview(uploadProgress)
        
        let cancelUploadAction = UIAlertAction(title: "CANCEL", style: .destructive, handler: { UIAlertAction in
            
            uploadRequest?.cancel()
            uploadRequest = nil
            alertProgressController.dismiss(animated: true, completion: {})
            
        })
        
        alertProgressController.addAction(cancelUploadAction)
        uploadProgress.frame = CGRect(x: 10, y: 50, width: screenWidth - 40, height: 10)
        self.parentViewController?.present(alertProgressController, animated: true, completion: nil)
        
        let ImageData = image.pngData()
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(ImageData!, withName: Str,fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in paramData {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: FINAL_API_URL)
        { (result) in
            
            switch result {
                
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    uploadProgress.progress = Float(progress.fractionCompleted)
                    alertProgressController.message = String(format: "กำลังส่งข้อมูลโปรดรอ...\nอัพโหลดเสร็จแล้ว %.2f %%", progress.fractionCompleted * 100.0)
                })
                
                upload.responseJSON(completionHandler: { (response) in
                    
                    alertProgressController.dismiss(animated: true, completion: {})
                    
                    switch (response.result) {
                        
                    case .success:
                        
                        do {
                            var temp_JSON: JSON = []
                            temp_JSON = try JSON(data: response.data!)
                            if temp_JSON["response_status"].bool == true {
                                
                                completionHandler(temp_JSON["response_data"])
                                
                            } else {
                                self.parentViewController?.showToast(message: "\(temp_JSON["response_message"].stringValue)")
                            }
                        }catch _ {
                            self.parentViewController?.showToast(message: "Can't convert response to JSON.")
                        }
                        
                        break
                        
                    case .failure( _):
                        
                        self.parentViewController?.showToast(message: "Can't connect to server")
                        
                        break
                    }
                })
                
            case .failure(let encodingError):
                
                alertProgressController.dismiss(animated: true, completion: {})
                if encodingError._code == NSURLErrorTimedOut {
                    self.parentViewController?.postAlert(APP_NAME, message: "Connect to server is time out.")
                } else {
                    self.parentViewController?.postAlert(APP_NAME, message: "Can't connect to server.")
                }
                
                break
                
            }
            
        }
    }
    
}

func getUserDetail(formKey keyStr: String) -> String {
    
    do {
        
        if let tempUserDetail = UserDefaults.standard.object(forKey: "UserDetail") {
            
            let temp_JSONData = try JSON(data: (tempUserDetail as! Data))
            
            return temp_JSONData["response_data"][0][keyStr].stringValue
            
        }
        
    } catch {
        
        return ""
        
    }
    
    return ""
    
}

func clearUserDetail() {
    
    UserDefaults.standard.set(nil, forKey: "UserDetail")
    
}
//UserDefaults.standard.set(response.data!, forKey: "UserDetail")
