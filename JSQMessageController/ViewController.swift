//
//  ViewController.swift
//  JSQMessageController
//
//  Created by Orange Apps on 21/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase

class ViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    
    let userDef = UserDef()
    
    let messageRef = FIRDatabase.database().reference().child("messages")

    var senderId2: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = userDef.readValue(identifier: "id")
        self.senderDisplayName = userDef.readValue(identifier: "name")
        print(self.senderId)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleBack))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 249/255,green: 180/255, blue: 40/255,alpha: 0)
        navigationController?.navigationBar.barStyle = .blackOpaque
        observerData()
        
    }
    
    func handleBack() {
        let usersViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "UserViewController")
        present(usersViewController!, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let newMessage = messageRef.childByAutoId()
        let newMessagData = ["text": text, "senderId": senderId, "senderDisplayName": senderDisplayName, "receiverId": userDef.readValue(identifier: "message_id")]
        newMessage.setValue(newMessagData)
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        print("didPressAccessoryButton")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let messageIndex = messages[indexPath.row]
        let bubble = JSQMessagesBubbleImageFactory()
        
        if messageIndex.senderId == self.senderId {
            return bubble?.outgoingMessagesBubbleImage(with: UIColor.orange)
        } else {
            return bubble?.incomingMessagesBubbleImage(with: UIColor.black)
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: "unk"), diameter: 20)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func observerData() {
        
        messageRef.observe(.childAdded, with: {snapshot in
            
            if let data = snapshot.value as? [String: AnyObject] {
                
                if let receiverId = data["receiverId"] as? String, let sender = data["senderId"] as? String {
                    
                    if receiverId == self.userDef.readValue(identifier: "message_id") {
                        
                        let senderDisplayName = data["senderDisplayName"] as? String
                        let message = data["text"] as? String
                        self.senderId2 = sender
                        self.messages.append(JSQMessage(senderId: self.senderId2, displayName: senderDisplayName, text: message))
                        
                    } else if sender == self.userDef.readValue(identifier: "message_id") {
                        
                        let senderDisplayName = data["senderDisplayName"] as? String
                        let message = data["text"] as? String
                        self.senderId2 = sender
                        self.messages.append(JSQMessage(senderId: self.senderId2, displayName: senderDisplayName, text: message))
                    }
                    
                    self.collectionView.reloadData()
                    
                }
            }
            
        })
    }
    

}

