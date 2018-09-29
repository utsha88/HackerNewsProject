//
//  HackerNewsDetailsViewController.swift
//  Omnify
//
//  Created by Utsha Guha on 9/26/18.
//  Copyright © 2018 Utsha Guha. All rights reserved.
//

import UIKit

class HackerNewsDetailsViewController: UIViewController,UITableViewDataSource,UIScrollViewDelegate {
    @IBOutlet weak var commentScrollView: UIScrollView!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var webButton: UIButton!
    @IBOutlet weak var commentSelected: UIImageView!
    @IBOutlet weak var articleSelected: UIImageView!
    @IBOutlet weak var newsWebView: UIWebView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsURL: UILabel!
    @IBOutlet weak var newsTime: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var commentTableView: UITableView!
    var newsCommentList:[Int] = []
    var newsId:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initialSetup()
        self.loadNewsDetails()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**** Supporting Methods to setup initial screen & switching between comment and articles screen: Begin ******/
    func initialSetup() {
        self.commentScrollView.addSubview(self.commentTableView)
        self.commentScrollView.addSubview(self.newsWebView)
        self.commentSelected(true)
    }
    
    func commentSelected(_ flag:Bool) {
        self.commentTableView.isHidden = !flag
        self.newsWebView.isHidden = flag
        self.commentSelected.isHidden = !flag
        self.articleSelected.isHidden = flag
    }
    /**** Supporting Methods to setup initial screen & switching between comment and articles screen: End ******/
    
    /************** Load News Details for selected News ID: Begin    **************/
    func loadNewsDetails() {
        let newsURLString:String = "https://hacker-news.firebaseio.com/v0/item/\(self.newsId).json?print=pretty"
        let myUrl = URL(string:newsURLString)
        let request = URLRequest(url:myUrl!)
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if error == nil{
                DispatchQueue.main.async {
                    let responseDictionary = try? JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
                    let time:Int = responseDictionary?[ConstantString.kHNNewsTimeKey] as! Int
                    self.newsTitle.text = responseDictionary?[ConstantString.kHNNewsTitleKey] as? String
                    self.newsAuthor.text = responseDictionary?[ConstantString.kHNNewsAuthorKey] as? String
                    self.newsURL.text = responseDictionary?[ConstantString.kHNNewsURLKey] as? String
                    self.newsTime.text = time.convertUnixTimeToDateString()
                    if (responseDictionary?.keys.contains(ConstantString.kHNNewsCommentIdsKey))!{
                        self.newsCommentList = responseDictionary?[ConstantString.kHNNewsCommentIdsKey] as! [Int]
                    }
                    if self.newsCommentList.count < 2{
                        self.commentButton.setTitle("\(self.newsCommentList.count) COMMENT", for: .normal)
                    }
                    else{
                        self.commentButton.setTitle("\(self.newsCommentList.count) COMMENTS", for: .normal)
                    }
                
                    if let urlText = self.newsURL.text{
                        self.newsWebView.loadRequest(NSURLRequest(url: NSURL(string: urlText)! as URL) as URLRequest)
                    }
                    self.commentTableView.reloadData()
                }
            }
            else{
                self.showAlert(heading: ConstantString.kHNNetworkErrorHeading, message: ConstantString.kHNNetworkErrorMessage, buttonTitle: ConstantString.kHNNAlertOK)
                return
            }
        }
        task.resume()
    }
    /************** Load News Details for selected News ID: End    **************/
    
    /************** Table view Datasource: Begin**************/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsCommentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HackerNewsDetailCellView = tableView .dequeueReusableCell(withIdentifier: ConstantString.kHNCommentCellID, for: indexPath) as! HackerNewsDetailCellView
        let commentId:Int = self.newsCommentList[indexPath.row]
        let commentURLString:String = "https://hacker-news.firebaseio.com/v0/item/\(commentId).json?print=pretty"
        let myUrl = URL(string:commentURLString)
        let request = URLRequest(url:myUrl!)
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if error == nil{
                DispatchQueue.main.async {
                    let responseDictionary = try? JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
                    if (responseDictionary != nil) {
                        let time:Int = responseDictionary![ConstantString.kHNNewsTimeKey] as! Int
                        cell.commentTitle.text = responseDictionary?[ConstantString.kHNNewsCommentTextKey] as! String?
                        cell.commentAuthor.text = responseDictionary?[ConstantString.kHNNewsAuthorKey] as! String?
                        cell.commentDate.text = time.convertUnixTimeToDateStringWithTime()
                    }
                }
            }
            else{
                self.showAlert(heading: ConstantString.kHNNetworkErrorHeading, message: ConstantString.kHNNetworkErrorMessage, buttonTitle: ConstantString.kHNNAlertOK)
                return
            }
        }
        task.resume()
    
        return cell
    }
    /************** Table view Datasource: End**************/
    
    /************** Action methods to display comments & Articles: Begin    **************/
    @IBAction func showCommentScreen(_ sender: Any) {
        self.commentSelected(true)
    }

    @IBAction func showWebScreen(_ sender: Any) {
        self.commentSelected(false)
        
    }
    /************** Action methods to display comments & Articles: End    **************/
    
}

