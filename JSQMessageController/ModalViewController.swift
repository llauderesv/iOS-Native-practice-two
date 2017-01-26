//
//  ModalViewController.swift
//  JSQMessageController
//
//  Created by Orange Apps on 25/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class ModalViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var txtPost: UITextView!
    @IBOutlet var backgroundView: UIView!
    
    let userDef = UserDef()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        backgroundView.layer.cornerRadius = 5
        txtPost.text = "What's on your mind?"
        txtPost.textColor = UIColor.lightGray
        txtPost.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtPost.textColor == UIColor.lightGray {
            txtPost.text = nil
            txtPost.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if txtPost.text.isEmpty {
            txtPost.text = "What's on your mind?"
            txtPost.textColor = UIColor.lightGray
        }
    }

    @IBAction func btnPost(_ sender: Any) {
    
        SwiftSpinner.show("Loading...", animated: true)
        
        Alamofire.request(Configuration.urlStr(urlData: "student_api/post_user"), method: .post,
                          parameters: ["student_id":userDef.readValue(identifier: "id"),
                                       "content": txtPost.text!]).responseString(completionHandler: {response in
        
            if let result = response.result.value {
                print(result)
                if result == "success" {
                    
                    SwiftSpinner.hide({
                        self.dismiss(animated: true, completion: nil)
                        
                        // Reload the tableView
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                        
                    })
                    
                }
                
            }
            
            
        })

        
    }
}
