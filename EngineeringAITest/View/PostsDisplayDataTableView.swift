//
//  PostsDisplayDataTableView.swift
//  EngineeringAITest
//
//  Created by Swaminath-Ojas on 15/10/19.
//  Copyright © 2019 Swaminath-Ojas. All rights reserved.
//

import UIKit

class PostsDisplayDataTableView: UITableView,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var numberOfRowsInTableView = NSMutableArray()
    var presntController: ViewController!
    var notFoundMessageString: String!
    var count = 1
    
    var selectedItem = String()
    var arraySelectedIndexes = [String]()

    func reloadTableViewWithData(dataDictionary: NSMutableArray, presentviewController: ViewController, withNotFoundMessage: String) {
        if withNotFoundMessage == "refresh"{
            arraySelectedIndexes.removeAll()
            self.presntController.navigationItem.title = ""
        }
        notFoundMessageString = withNotFoundMessage
        numberOfRowsInTableView = dataDictionary
        presntController = presentviewController
        self.dataSource = self
        self.delegate = self
        self.separatorInset = .zero
        self.layoutMargins = .zero
        self.tableFooterView = UIView()
        self.separatorStyle = .singleLine
        
        self.reloadData()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInTableView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.selectionStyle = .none
        if indexPath.row == numberOfRowsInTableView.count - 1 { // last cell
            count += 1
            print(count)
            presntController.getPostsData(count: count) // increment `fromIndex` by 20 before server call
        }
        let data = numberOfRowsInTableView[indexPath.row]
        if (data as AnyObject).object(forKey: "title") as? String != nil {
            cell.label_Title.text = (data as AnyObject).object(forKey: "title") as? String
        }
        if (data as AnyObject).object(forKey: "created_at") as? String != nil {
            cell.label_CreatedDate.text = (data as AnyObject).object(forKey: "created_at") as? String
        }
        
        if self.selectedItem == (data as AnyObject).object(forKey: "title") as? String{
            cell.toggleSwitch.isOn = true
        }else{
            cell.toggleSwitch.isOn = false
        }

        for item in arraySelectedIndexes {
            if let originalString = (data as AnyObject).object(forKey: "title"){
                if ((originalString as AnyObject).contains(item)){
                    cell.toggleSwitch.isOn = true
                }
            }
        }

        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = numberOfRowsInTableView[indexPath.row]
        if let item = (data as AnyObject).object(forKey: "title") as? String{
            self.selectedItem = item
            print("selectedItem : \(self.selectedItem)")
            if arraySelectedIndexes.contains(self.selectedItem) {
                print("Yes Already Checked")
                
                if let index = arraySelectedIndexes.firstIndex(of: self.selectedItem) {
                    self.selectedItem = "NOTSELECTED"
                    arraySelectedIndexes.remove(at: index)
                    self.presntController.navigationItem.title = String(arraySelectedIndexes.count)

                }
            }
            else{
                print("New Selection")
                self.arraySelectedIndexes.append(self.selectedItem)
                self.presntController.navigationItem.title = String(arraySelectedIndexes.count)
            }
            print("arraySelectedIndexes : \(self.arraySelectedIndexes)")
            self.reloadData()
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
