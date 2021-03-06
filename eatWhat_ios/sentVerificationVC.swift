//
//  waitingForVerificationVC.swift
//  eatWhat_ios
//  新使用者寄驗證信
//  Created by 徐浩哲 on 2018/10/6.
//  Copyright © 2018 徐浩哲. All rights reserved.
//

import UIKit
import Firebase

class sentVerificationVC: UIViewController {

    func showMessage( enter : String){
        let alertController = UIAlertController(title: enter, message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "我瞭解了", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController,animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    @IBAction func sentEmail(_ sender: UIButton) {
        if Auth.auth().currentUser != nil {//if使用者 == true
            let user = Auth.auth().currentUser//user抓現在使用者
            if let user = user {
                let uid = user.uid
                let emailGet = user.email
                
                print(uid)
                print(emailGet as Any)
                
                let actionCodeSettings = ActionCodeSettings()
                actionCodeSettings.url = URL(string: "https://www.eatwhat-3582b.firebaseapp.com")
                actionCodeSettings.handleCodeInApp = true
                actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
                Auth.auth().currentUser?.sendEmailVerification { (error) in//寄出驗證信
                    let gg:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let MainPage :MainPage  = gg.instantiateViewController(withIdentifier: "MainPage") as! MainPage
                    self.present(MainPage ,animated: true,completion: nil)
                    if error != nil{
                        print("firebase has some problems")
                    }
                }
            }
        }
    }
}
