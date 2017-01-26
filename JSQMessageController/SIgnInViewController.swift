//
//  SIgnInViewController.swift
//  JSQMessageController
//
//  Created by Orange Apps on 21/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import Firebase

class SIgnInViewController: UIViewController {

    
    @IBOutlet var signIn: UIButton!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signIn.layer.cornerRadius = 5
        txtEmail.text = "llauderesv@gmail.com"
        txtPassword.text = "pogi"
        txtEmail.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        txtPassword.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        txtEmail.layer.cornerRadius = 3
        txtPassword.layer.cornerRadius = 3
        
        txtEmail.attributedPlaceholder =
            NSAttributedString(string: "Email address:", attributes:[NSForegroundColorAttributeName : UIColor.white])
        txtPassword.attributedPlaceholder =
            NSAttributedString(string: "Password:", attributes:[NSForegroundColorAttributeName : UIColor.white])
        
        txtEmail.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        txtPassword.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        
        let regViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        present(regViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnListener(_ sender: Any) {
        
        guard let email_address = txtEmail.text, let password = txtPassword.text else {
            return
        }
        
        SwiftSpinner.show("Loading...", animated: true)
        
        Alamofire.request(Configuration.urlStr(urlData: "student_api/login_student"), method: .post, parameters: ["email_address": email_address, "password": password]).responseJSON(completionHandler: { response in
            
            if let result = response.result.value {
                
                
                if let json = result as? NSDictionary {
                    print(json);
                    if let status = json["status"] as? String, let id = json["id"] as? String,
                        let name = json["name"] as? String {
                        
                        if status == "success" {
                            
                            let userDef = UserDef()
                            
                            let newsFeedViewController =
                                self.storyboard?.instantiateViewController(withIdentifier: "NavNewsFeed")
                            
                            SwiftSpinner.hide({
                                self.present(newsFeedViewController!, animated: true, completion: nil)
                            })
                            
                            userDef.addValue(identifier: "name", value: name)
                            userDef.addValue(identifier: "id", value: id)
                            
                        } else if status == "failed" {
                            
                            SwiftSpinner.hide()
                            self.initAlertDialog(title: "Login failed", message: "Invalid email address or password", action: "Try again")
                            
                        }
                        
                    }
                    
                }
                
            } else {
                
                SwiftSpinner.hide()
            }
            
        })
    }
    
    func initAlertDialog(title: String, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
