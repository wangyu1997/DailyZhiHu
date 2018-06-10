//
//  HomeVCTableViewController.swift
//  DrWy
//
//  Created by wangyu on 2018/6/10.
//  Copyright © 2018 wangyu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeVC: UITableViewController {
    
    var datas: [Story] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        let nib = UINib.init(nibName: "HomeCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "homeCell")        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }
    
    func loadData()  {
        let url = news_api+"latest"
        Alamofire.request(url,method:.get, parameters: nil, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    print("Success with JSON: \(JSON)")
                    let json = JSON as! NSDictionary
                    //example if there is an id
                   let storys = StoryList(fromDictionary: json)
                    print(storys.date)
                    self.datas = storys.stories
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                    }
                case .failure(_):
                    SwiftNotice.showNoticeWithText(.error, text: "获取数据失败", autoClear: true, autoClearTime: 3000)
                }
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let story = datas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        let url = URL(string: story.images[0])!
        cell.picImg.af_setImage(withURL: url)
        cell.title.numberOfLines = 2
        cell.title.text = story.title

        // Configure the cell...

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
