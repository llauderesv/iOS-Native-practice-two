//
//  NewsFeedController.swift
//  JSQMessageController
//
//  Created by Orange Apps on 23/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class NewsFeedController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tblNewsFeed: UITableView!
    
    var newsFeed: [NewsFeed]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "NewsFeed"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign out", style: .plain, target: self, action: #selector(handleLogout))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(handlePostListener))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(red: 249/255,green: 180/255, blue: 40/255,alpha: 0)
        navigationController?.navigationBar.barStyle = .blackOpaque
        NotificationCenter.default.addObserver(self, selector: #selector(NewsFeedController.loadList),name: NSNotification.Name(rawValue: "load"), object: nil)
        
        self.tblNewsFeed.estimatedRowHeight = 400
        self.tblNewsFeed.rowHeight = UITableViewAutomaticDimension
        onloadNewsFeed();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadList(notification: NSNotification){
        onloadNewsFeed()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /**/let newsFeedCell = Bundle.main.loadNibNamed("NewsFeedContent", owner: self, options: nil)?.first as! NewsFeedContent
        newsFeedCell.imgUser.image = UIImage(named: "steve")
        newsFeedCell.lblUser.text = newsFeed?[indexPath.row].name
        newsFeedCell.lblTimePosted.text = newsFeed?[indexPath.row].date
        newsFeedCell.lblContent.text = newsFeed?[indexPath.row].announcement
        newsFeedCell.btnLikeContent.tag = indexPath.row
        newsFeedCell.btnLikeContent.addTarget(self, action: #selector(NewsFeedController.btnLikeListener), for: .touchUpInside)
        return newsFeedCell
        
        /*  if (indexPath.row % 2) == 1 {
         let newsFeedCell = Bundle.main.loadNibNamed("NewsFeedContent", owner: self, options: nil)?.first as! NewsFeedContent
         newsFeedCell.imgUser.image = UIImage(named: "steve")
         newsFeedCell.lblUser.text = newsFeed?[indexPath.row].name
         newsFeedCell.lblTimePosted.text = "2 minutes ago"
         newsFeedCell.lblContent.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
         newsFeedCell.btnLikeContent.tag = indexPath.row
         newsFeedCell.btnLikeContent.addTarget(self, action: #selector(NewsFeedController.btnLikeListener), for: .touchUpInside)
         return newsFeedCell
         } else {
         let newsFeedCell = Bundle.main.loadNibNamed("NewsFeedContentCell", owner: self, options: nil)?.first as! NewsFeedContentCell
         newsFeedCell.imgUser.image = UIImage(named: "steve")
         newsFeedCell.lblUser.text = "Steve Jobs"
         newsFeedCell.lblTimePosted.text = "2 minutes ago"
         newsFeedCell.lblContent.text = "On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish."
         return newsFeedCell
         } */
    }
    
    func btnLikeListener(sender: UIButton){
        let buttonTag = sender.tag
        print(newsFeed?[buttonTag].announcement! ?? 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed?.count ?? 0
    }
    
    func handleLogout() {
        let signInViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "SignViewController") as! SIgnInViewController
        present(signInViewController, animated: true, completion: nil)
    }
    
    func handlePostListener() {
        let signInViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "ModalViewController") as! ModalViewController
        signInViewController.modalPresentationStyle = .overCurrentContext
        present(signInViewController, animated: true, completion: nil)
    }
    
    func onloadNewsFeed() {
        Alamofire.request(Configuration.urlStr(urlData: "student_api/user_post"), method: .get).responseJSON(completionHandler: { response in
            if let result = response.result.value {
                SwiftSpinner.hide()
                self.newsFeed = [NewsFeed]()
                if let json = result as? NSDictionary {
                    if let post = json["post"] as? [[String: AnyObject]] {
                        for post2 in post {
                            let newsFeedData = NewsFeed()
                            if let name = post2["name"] as? String, let announcement = post2["announcement"] as? String, let date = post2["date"] as? String,
                                let id = post2["id"] as? String {
                                newsFeedData.name = name
                                newsFeedData.announcement = announcement
                                newsFeedData.date = date
                                newsFeedData.id = id
                            }
                            self.newsFeed?.append(newsFeedData)
                        }
                        
                    }
                    
                    // Reload the tableView
                    DispatchQueue.main.async {
                        self.tblNewsFeed.reloadData()
                    }
                    
                    
                }
                
                
            } else {
                
                SwiftSpinner.hide()
            }
        })
    }
    
    
    
    
}
