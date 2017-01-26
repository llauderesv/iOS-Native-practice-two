//
//  RegisterViewController.swift
//  JSQMessageController
//
//  Created by Orange Apps on 21/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import Firebase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var regBtn: UIButton!
    @IBOutlet var txtEmailAddress: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var imgUser: UIImageView!
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regBtn.layer.cornerRadius = 5
        txtName.text = "Vincent Llauderes"
        txtEmailAddress.text = "llauderesv@gmail.com"
        txtPassword.text = "pogi"
        
        txtName.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        txtEmailAddress.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        txtPassword.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        txtEmailAddress.layer.cornerRadius = 3
        txtPassword.layer.cornerRadius = 3
        txtName.layer.cornerRadius = 3
        
        txtEmailAddress.attributedPlaceholder =
            NSAttributedString(string: "Email address:", attributes:[NSForegroundColorAttributeName : UIColor.white])
        txtPassword.attributedPlaceholder =
            NSAttributedString(string: "Password:", attributes:[NSForegroundColorAttributeName : UIColor.white])
        txtName.attributedPlaceholder =
            NSAttributedString(string: "Name:", attributes:[NSForegroundColorAttributeName : UIColor.white])
        
        txtEmailAddress.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        txtPassword.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        txtName.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.tappedMe))
        imgUser.addGestureRecognizer(tap)
        imgUser.isUserInteractionEnabled = true
    
    }
    
    func tappedMe() {
        
        let imgPicker = UIImagePickerController()
        
        imgPicker.delegate = self
        
        present(imgPicker, animated: true, completion: nil)
    }
    
    func launchGallery() {
        
        let imgPicker = UIImagePickerController()
        
        imgPicker.delegate = self
        
        present(imgPicker, animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImagePicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImagePicker = editedImage
        } else if let orgImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImagePicker = orgImage
            
        }
        
        if let selImage = selectedImagePicker {
            
            imgUser.image = selImage
            
            let imageData = UIImagePNGRepresentation(selImage)
            
            if let imgBytes = imageData {
                
                print("Hello \(imgBytes)")
                
                Alamofire.upload(imgBytes, to: "https://httpbin.org/post").responseJSON { response in
                    debugPrint(response)
                }
                
            }
        }
        
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func backListener(_ sender: Any) {
        let signInViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "SignViewController") as! SIgnInViewController
        present(signInViewController, animated: true, completion: nil)
    }
    
    @IBAction func registerListener(_ sender: Any) {
        
        guard let name = txtName.text, let email_address = txtEmailAddress.text, let password = txtPassword.text else{
            print("All fields are required!")
            return
        }
        
        SwiftSpinner.show("Loading...", animated: true)
        
        Alamofire.request(Configuration.urlStr(urlData: "insert_students.php"), method: .post, parameters: ["id":1, "name": name, "email_address": email_address, "password": password]).responseJSON(completionHandler: {response in
            
            if let result = response.result.value {
                
                if let json = result as? NSDictionary {
                    
                    if let status = json["status"] as? String,let id2 = json["id"] as? Int {
                        
                        if status == "TRUE" {
                            let userDef = UserDef()
                            let messageViewController =
                                self.storyboard?.instantiateViewController(withIdentifier: "MessageController")
                            
                            SwiftSpinner.hide({
                                self.present(messageViewController!, animated: true, completion: nil)
                            })
                            
                            userDef.addValue(identifier: "id", value: String(id2))
                            
                        } else {
                            
                            SwiftSpinner.hide()
                        }
                        
                    }
                    
                }
                
            }
            
        })
        
    }
    
    func initAlertDialog(title: String, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func insertIntoFireBase(values: [String: AnyObject]) {
        
        let ref = FIRDatabase.database().reference(fromURL: "https://orangeappschat.firebaseio.com/")
        
        let userChild = ref.child("users").childByAutoId()
        userChild.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err ?? "Error")
                return
            }
            
            print("Successfully save to FCM!")
            
            
            /*self.messagesController?.navigationItem.title = values["name"] as? String
            let user = User()
            user.setValuesForKeys(values)
            
            self.messagesController?.setupNavBarTitle(user: user)
            
            // Close the scene upon registration...
            self.dismiss(animated: true, completion: nil)*/
            
            //print("Save user successfully into FCM db")
            
            
        })
    }
    
}
