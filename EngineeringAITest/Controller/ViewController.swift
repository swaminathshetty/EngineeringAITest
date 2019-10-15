//
//  ViewController.swift
//  EngineeringAITest
//
//  Created by Swaminath-Ojas on 15/10/19.
//  Copyright © 2019 Swaminath-Ojas. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController{
    
    @IBOutlet weak var postsDataTableView: PostsDisplayDataTableView!
    var refreshControl = UIRefreshControl()
    var postDataArray = NSMutableArray()
    var count:Int!
    var pullString = "NOTFROMPULL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postsDataTableView.rowHeight = UITableView.automaticDimension
        self.postsDataTableView.estimatedRowHeight = 80
        
        self.navigationItem.title = String(0)

        self.refreshControlConfiguration()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getPostsData(count: 1)
    }
    //RefreshControl configuration
    func refreshControlConfiguration(){
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        postsDataTableView.addSubview(refreshControl)
        self.navigationItem.title = String(0)

        count = 1
    }
    //Pull to refresh Action
    @objc func refresh(sender:AnyObject) {
        print("Pull to refresh called")
        self.postDataArray.removeAllObjects()
        pullString = "PULLREFRESH"
        self.getPostsData(count: 1)
    }
    //Getting all posts data from getMethod
    func getPostsData(count:Int) {
        let service: APIWapper = APIWapper.init()
        service.startActivityIndictor()
        let url =  "https://hn.algolia.com/api/v1/search_by_date?tags=story&page="
        let finalString = url + String(count)
        Alamofire.request(finalString, method: .get, parameters: ["": ""], encoding: URLEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            switch response.result {
            case .success:
                service.stopActivityIndicator()
                if response.result.value != nil {
                    let dict:NSDictionary! = response.result.value as? NSDictionary
                    self.postDataArray.addObjects(from: (dict.value(forKey: "hits") as! [Any]))
                    print(self.postDataArray.count)
                    //self.navigationItem.title = String(self.postDataArray.count)
                    if self.pullString == "PULLREFRESH"{
                        self.pullString = ""
                        self.postsDataTableView.reloadTableViewWithData(dataDictionary: (self.postDataArray as NSArray).mutableCopy() as! NSMutableArray, presentviewController: self, withNotFoundMessage: "refresh")
                    }
                    else{
                        
                        self.postsDataTableView.reloadTableViewWithData(dataDictionary: (self.postDataArray as NSArray).mutableCopy() as! NSMutableArray, presentviewController: self, withNotFoundMessage: "NOT")
                    }
                    self.refreshControl.endRefreshing()
                    
                }
            case .failure:
                service.stopActivityIndicator()
                self.refreshControl.endRefreshing()
                print(response.result.error as Any)
            }
        }
    }
    
}

