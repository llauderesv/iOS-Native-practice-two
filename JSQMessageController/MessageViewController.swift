//
//  MessageViewController.swift
//  JSQMessageController
//
//  Created by Orange Apps on 22/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var message: [Messages]? = []
    
    var userDef = UserDef()
    
    let messageRef = FIRDatabase.database().reference().child("messages")
    
    @IBOutlet var tblViewMessage: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.title = "Messages"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "create"), style: .plain, target: self, action: #selector(handleNewMessage))
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 249/255,green: 180/255, blue: 40/255,alpha: 0)
        navigationController?.navigationBar.barStyle = .blackOpaque
        observerData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func handleNewMessage() {
        let usersViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "UserViewController")
        present(usersViewController!, animated: true, completion: nil)
    }
    
    func handleLogout() {
        let signInViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "SignViewController") as! SIgnInViewController
        present(signInViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messagesCell", for: indexPath) as! MessagesCell
        cell.imgUser?.image = UIImage(named: "unk.png")
        cell.name.text = message?[indexPath.row].name
        cell.message.text = message?[indexPath.row].message
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.message?.count ?? 0
    }
    
    func observerData() {
        
        messageRef.observe(.childAdded, with: {snapshot in
            
            print(snapshot)
            
            if let data = snapshot.value as? [String: AnyObject] {
                
                self.message = [Messages]()
                
                if let receiverId = data["receiverId"] as? String {
                    
                    let userMessage = Messages()
                    
                    if receiverId == self.userDef.readValue(identifier: "id") {
                        
                        let name = data["senderDisplayName"] as? String
                        let messageData = data["text"] as? String
                        
                        userMessage.name = name
                        userMessage.message = messageData
                        
                    }
                    self.message?.append(userMessage)

                }
                
            }
            
            // Reload the tableView
            DispatchQueue.main.async {
                self.tblViewMessage.reloadData()
            }
            
        })
    }
    
}
