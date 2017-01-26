//
//  SampleViewController.swift
//  JSQMessageController
//
//  Created by Orange Apps on 22/11/2016.
//  Copyright © 2016 Orange Apps. All rights reserved.
// SampleViewController

import UIKit

class SampleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var `switch`: UISegmentedControl!
    
    var articles : [Article]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchArticle(url: "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=e9e719462ac34df0a024d71fff0989ad")
    }
    
    func fetchArticle(url: String) {
        
        // Initialize the url...
        let getRequest = URLRequest(url: URL(string: url)!)
        
        // Execute the data task...
        let task = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            self.articles = [Article]()
            
            do {
                
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                
                
                // Get the json articles data and convert it into dictionary...
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    
                    for articleFromJson in articlesFromJson {
                        let article = Article()
                        
                        if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String,
                            let desc = articleFromJson["description"] as? String, let url =  articleFromJson["url"] as? String, let imageToUrl = articleFromJson["urlToImage"] as? String {
                            
                            article.headLine = title
                            article.desc = desc
                            article.author = author
                            article.imageUrl = imageToUrl
                            article.url = url
                            
                            
                        }
                        self.articles?.append(article)
                        
                    }
                    
                }
                
                // Reload the tableView
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            } catch let error {
                print(error)
            }
            
            
        }
        
        task.resume()
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        cell.title.text = self.articles?[indexPath.item].headLine
        cell.author.text = self.articles?[indexPath.item].author
        cell.desc.text = self.articles?[indexPath.item].desc
        cell.imgView?.downloadImage(from: (self.articles?[indexPath.item].imageUrl)!)
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        
        switch self.switch.selectedSegmentIndex {
            
        case 0:
            fetchArticle(url: "https://newsapi.org/v1/articles?source=techcrunch&sortBy=top&apiKey=e9e719462ac34df0a024d71fff0989ad")
            print("segment 0")
            break;
        case 1:
            print("segment 1")
            fetchArticle(url: "https://newsapi.org/v1/articles?source=techradar&sortBy=top&apiKey=e9e719462ac34df0a024d71fff0989ad")
            break;
        default:
            print("")
        }
        // Reload the tableView
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

// Fetch the imageview in the url...
extension UIImageView {
    
    func downloadImage(from url: String) {
        
        let urlRequest = URLRequest(url: URL(string : url)!)
        
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                print(error ?? "Hello")
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
            
        }
        
        task.resume()
        
    }
}
