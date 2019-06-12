//
//  NNFWorkTableView.swift
//  Music Tailor
//
//  Created by Saharat Sittipanya on 17/1/62.
//  Copyright © พ.ศ. 2562 Wolves Corporation. All rights reserved.
//

import Foundation


/*
 // Main.Story -> Main.Story
 
 if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
 self.present(viewController, animated: true, completion: nil)
 }
 
 // Main.Story -> UIViewController
 
 let viewController = MainMenuViewController(nibName: "MainMenuViewController", bundle: nil)
 let navController = UINavigationController(rootViewController: viewController)
 navController.navigationBar.isHidden = true
 self.present(navController, animated: true, completion: nil)
 
 // UIViewController -> UIViewController
 
 let viewController = RefuelDetailViewController(nibName: "RefuelDetailViewController", bundle: nil)
 self.navigationController?.pushViewController(viewController, animated: true)
 
 
 // UIViewController -> Main.Story
 
 if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
 self.present(viewController, animated: true, completion: nil)
 }
 
 
 
 
 
 
 
 DispatchQueue.main.async {
 
 }
 
 
 
 
 override func willMove(toWindow newWindow: UIWindow?) {
 super.willMove(toWindow: newWindow)
 
 if newWindow == nil {
 // UIView disappear
 } else {
 // UIView appear
 }
 }
 
 
 
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }
 
 
 
 
 
 // --> TableView
 
 @IBOutlet weak var tableView: NNTableView! {
 didSet {
 
 self.tableView.delegate = self
 self.tableView.dataSource = self
 self.tableView.register(UINib(nibName: "PersonalListTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonalListTableViewCell")
 self.tableView.addRefresher {
 
 }
 }
 }
 
 let cell = tableView.dequeueReusableCell(withIdentifier: "") as! CLASS
 cell.selectionStyle = .none
 return cell

 
 
 
 // --> CollectionView
 
 @IBOutlet weak var collectionView: UICollectionView! {
 didSet {
 
 self.collectionView.delegate = self
 self.collectionView.dataSource = self
 
 self.collectionView.register(UINib(nibName: "ServiceListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ServiceListCollectionViewCell")
 
 let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
 layout.minimumInteritemSpacing = 0
 layout.minimumLineSpacing = 0
 layout.scrollDirection = .horizontal
 self.collectionView!.collectionViewLayout = layout
 
 }
 }
 
 extension ServicePagerViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return 6
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
 let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceListCollectionViewCell", for: indexPath) as! ServiceListCollectionViewCell
 
 
 
 return cell
 
 }
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
 return CGSize(width: 110.0, height: 140.0)
 
 }
 
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 
 switch indexPath.row {
 
 case 0:
 
 let viewController = RiseGoViewController(nibName: "RiseGoViewController", bundle: nil)
 self.parentViewController?.navigationController?.pushViewController(viewController, animated: true)
 
 break
 
 default: break
 
 }
 
 }
 
 }
 
 
 
 
 UIView.animate(withDuration: 0.7) {
 self.view.layoutIfNeeded()
 }
 
 
 
 // --> UIView
 
 override init(frame: CGRect) {
 super.init(frame: frame)
 }
 
 required init(coder: NSCoder) {
 super.init(coder: coder)!
 }
 
 func loadNib() -> UIView {
 let bundle = Bundle(for: type(of: self))
 let nibName = type(of: self).description().components(separatedBy: ".").last!
 let nib = UINib(nibName: nibName, bundle: bundle)
 return nib.instantiate(withOwner: self, options: nil).first as! UIView
 }
 
 override func awakeFromNib() {
 
 }
 
 
 
 
 var m_HomeView: HomeView!
 
 self.m_HomeView = HomeView().loadNib() as? HomeView
 self.m_HomeView.frame.size = self.view.frame.size
 self.m_HomeView.transform = self.view.transform
 self.m_HomeView.alpha = 0
 self.view.addSubview(self.m_HomeView)
 
 UIView.animate(withDuration: 0.5, delay: 0.7, options: .transitionFlipFromTop, animations: {
 
 
 
 }, completion: nil)
 
 
 UIView.animate(withDuration: 0.5, delay: 0.0, options: .transitionFlipFromBottom, animations: {
 
 
 
 }, completion: { (finished: Bool) in
 
 
 
 })
 
 
 
 override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
 self.view.endEditing(true)
 }

 
 
 
 
 
 // Define your models like regular Swift classes
 class Dog: Object {
 @objc dynamic var name = ""
 @objc dynamic var age = 0
 }
 class Person: Object {
 @objc dynamic var name = ""
 @objc dynamic var picture: Data? = nil // optionals supported
 let dogs = List<Dog>()
 }
 
 // Use them like regular Swift objects
 let myDog = Dog()
 myDog.name = "Rex"
 myDog.age = 1
 print("name of dog: \(myDog.name)")
 
 // Get the default Realm
 let realm = try! Realm()
 
 // Query Realm for all dogs less than 2 years old
 let puppies = realm.objects(Dog.self).filter("age < 2")
 puppies.count // => 0 because no dogs have been added to the Realm yet
 
 // Persist your data easily
 try! realm.write {
 realm.add(myDog)
 }
 
 // Queries are updated in realtime
 puppies.count // => 1
 
 // Query and update from any thread
 DispatchQueue(label: "background").async {
 autoreleasepool {
 let realm = try! Realm()
 let theDog = realm.objects(Dog.self).filter("age == 1").first
 try! realm.write {
 theDog!.age = 3
 }
 }
 }

 
 
 
 
 // --> For Loop Reference
 
 for i in 0...7 {
 let leftEarSlider = self.value(forKey: String(format: "m_LeftEarSlider%d", i)) as! NNCustomSlider
 leftEarSlider.setThumbImage(UIImage(named: "IconThumb_Small"), for: .normal)
 let newLeftEar = self.newEarsProfile.value(forKey: String(format: "EQLeftEar%d", i)) as! Float
 leftEarSlider.value = newLeftEar
 let rightEarSlider = self.value(forKey: String(format: "m_RightEarSlider%d", i)) as! NNCustomSlider
 rightEarSlider.setThumbImage(UIImage(named: "IconThumb_Small"), for: .normal)
 let newRightEar = self.newEarsProfile.value(forKey: String(format: "EQRightEar%d", i)) as! Float
 rightEarSlider.value = newRightEar
 }
 
 
 
 
 // --> API CALL
 
 func connectAPI_getList() {
 if self.m_loading.isAnimating {
 return
 }
 self.m_loading.startAnimating()
 let manager = Alamofire.SessionManager.default
 manager.session.configuration.timeoutIntervalForRequest = 10
 let data: Dictionary = [
 "apikey": FINAL_API_KEY,
 "code": CODE_STOCK,
 "action": ""
 ] as [String : Any]
 manager.request(FINAL_API_URL, method: .post, parameters: data)
 .downloadProgress { progress in
 }
 .responseJSON() {
 response in
 self.m_loading.stopAnimating()
 switch (response.result) {
 case .success:
 var temp_JSON: JSON = []
 do {
 temp_JSON = try JSON(data: response.data!)
 if temp_JSON["response_status"].bool == true {
 
 
 
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
 
 
 
 
 func connectAPI_EditProfileImg(_ image: UIImage) {
 
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
 
 let parameters = [
 "apikey": FINAL_API_KEY,
 "code" : FINAL_CODE_USER,
 "action": ""
 ]
 Alamofire.upload(multipartFormData: { multipartFormData in
 multipartFormData.append(ImageData!, withName: "profile_image",fileName: "file.jpg", mimeType: "image/jpg")
 for (key, value) in parameters {
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
 
 upload.responseString { response in
 
 alertProgressController.dismiss(animated: true, completion: {})
 switch (response.result) {
 case .success:
 
 
 
 break
 case .failure( _):
 self.postAlert(APP_NAME, message: "Can't connect to server")
 break
 }
 }
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

 
 
 
*/
