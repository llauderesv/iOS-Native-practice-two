//
//  ViewController.swift
//  JSQMessageController
//
//  Created by Orange Apps on 21/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit
import JSQMessagesViewController


class ChatLogController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = "1"
        self.senderDisplayName = "Vincent Llauderes"
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        
    }
    
    func handleLogout() {
        let signInViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "SignViewController") as! SIgnInViewController
        present(signInViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        //        print("didPressSend")
        print("sender id: " + senderId)
        print("senderDisplayName" + senderDisplayName)
        messages.append(JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text))
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        print("didPressAccessoryButton")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(messages.count)
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubble = JSQMessagesBubbleImageFactory()
        return bubble?.outgoingMessagesBubbleImage(with: UIColor.orange)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
}

