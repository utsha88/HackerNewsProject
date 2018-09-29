//
//  HackerNewsViewController.swift
//  Omnify
//
//  Created by Utsha Guha on 9/26/18.
//  Copyright © 2018 Utsha Guha. All rights reserved.
//

import UIKit

class HackerNewsViewController: UIViewController,UITableViewDataSource {
    var newsArray:[Int] = []
    var counter:Int = 0
    
    //var newsDetailsList:[Dictionary<String, Any>] = []
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var lastUpdateField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadBreakingNewsId()
        _ = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)   // Incrementing the count after every minuite to get the details of when last time the news were fetched.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /************** Calculating the last fetched News time: Begin   **************/
    @objc func updateTimer() {
        counter = counter+1
        self.lastUpdateField.text = "Updated \(counter) mins ago"
    }
    /************** Calculating the last fetched News time: End   **************/
    
    /************** Fetching the top Stories: Begin   **************/
    func loadBreakingNewsId() {
        let myUrl = URL(string:ConstantString.kHNFetchTopStoriesURL)
        let request = URLRequest(url:myUrl!)
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if error == nil{
                self.counter = 0
                self.newsArray = try! JSONSerialization.jsonObject(with: data!, options: []) as! [Int]
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            }
            else{
                self.showAlert(heading: ConstantString.kHNNetworkErrorHeading, message: ConstantString.kHNNetworkErrorMessage, buttonTitle: ConstantString.kHNNAlertOK)
                return
            }
        }
        task.resume()
    }
    /************** Fetching the top Stories: End   **************/
    
    /************** Table view Datasource: Begin**************/
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HackerNewsModelView = tableView .dequeueReusableCell(withIdentifier: ConstantString.kHNNewsCellID, for: indexPath) as! HackerNewsModelView
        let newsURLString:String = "https://hacker-news.firebaseio.com/v0/item/\(self.newsArray[indexPath.row]).json?print=pretty"

        let myUrl = URL(string:newsURLString)
        let request = URLRequest(url:myUrl!)
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            if error == nil{
                DispatchQueue.main.async {
                    let responseDictionary = try? JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
                    var noOfComment:Int = 0
                    if (responseDictionary?[ConstantString.kHNNewsCommCountKey]) != nil{
                        noOfComment = responseDictionary?[ConstantString.kHNNewsCommCountKey] as! Int
                    }
                    let time:Int = responseDictionary?[ConstantString.kHNNewsTimeKey] as! Int
                    let score:Int = responseDictionary?[ConstantString.kHNNewsScoreKey] as! Int
                    cell.newsTitle.text = responseDictionary?[ConstantString.kHNNewsTitleKey] as? String
                    cell.newsAuthor.text = responseDictionary?[ConstantString.kHNNewsAuthorKey] as? String
                    cell.newsCommentCount.text = String(describing: noOfComment)
                    cell.newsURL.text = responseDictionary?[ConstantString.kHNNewsURLKey] as? String
                    cell.newsTime.text = time.timeIntervalSinceCurrentDate()
                    cell.newsScore.text = String(describing: score)
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
    
    /************** Segue Method to pass selected News ID to detailed screen: Begin**************/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ConstantString.kHNNewsDetailsSegue {
            if let destination = segue.destination as? HackerNewsDetailsViewController {
                destination.newsId = self.newsArray[(self.newsTableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    /************** Segue Method to pass selected News ID to detailed screen: End**************/
    
    /************** Refresh Action: Begin   **************/
    @IBAction func refreshNews(_ sender: Any) {
        self.loadBreakingNewsId()
    }
    /************** Refresh Action: End   **************/
    
}
