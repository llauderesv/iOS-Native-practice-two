//
//  UsersViewController.swift
//  JSQMessageController
//
//  Created by Orange Apps on 21/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tblViewUsers: UITableView!
    
    var user: [Users]? = []
    
    let userDef = UserDef()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backListener))
        loadUsers(id: userDef.readValue(identifier: "id"))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 249/255,green: 180/255, blue: 40/255,alpha: 0)
        navigationController?.navigationBar.barStyle = .blackOpaque
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func backListener() {
        let messageViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "MessageController")
        
        present(messageViewController!, animated: true, completion: nil)
    }
    
    func loadUsers(id: String) {
        
        SwiftSpinner.show("Fetching users...", animated: true)
        
        Alamofire.request(Configuration.urlStr(urlData: "select_students.php"), method: .post, parameters: ["id": id]).responseJSON(completionHandler: { response in
            
            if let result = response.result.value {
                
                SwiftSpinner.hide()
                print(result)
                
                self.user = [Users]()
                    
                    if let json = result as? NSDictionary {
                        
                        if let status = json["students"] as? [[String : AnyObject]] {
                            
                            for status2 in status {
                                
                                let usersData = Users()
                                
                                if let email_address = status2["email_address"] as? String, let id2 = status2["id"] as? String, let name = status2["name"] as? String {
                                    
                                    usersData.id = id2
                                    usersData.name = name
                                    usersData.email_address = email_address
                                    
                                }
                                
                                self.user?.append(usersData)
                                
                            }
                            
                        }
                        
                        // Reload the tableView
                        DispatchQueue.main.async {
                            self.tblViewUsers.reloadData()
                        }
                        
                    }

                
            } else {
                
                SwiftSpinner.hide()
            }
            
        })
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        cell.imgUser?.image = UIImage(named: "unk.png")
        cell.stud_id.text = self.user?[indexPath.row].id
        cell.name.text = self.user?[indexPath.row].name
        cell.email.text = self.user?[indexPath.row].email_address
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.user?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController =
            self.storyboard?.instantiateViewController(withIdentifier: "ChatNavigationController")
    
        present(viewController!, animated: true, completion: nil)
        userDef.addValue(identifier: "message_id", value: (self.user?[indexPath.row].id)!)
        

    }
    
    
}

