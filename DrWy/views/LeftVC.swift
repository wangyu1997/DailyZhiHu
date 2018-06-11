//
//  LeftVC.swift
//  DrWy
//
//  Created by wangyu on 2018/6/11.
//  Copyright © 2018 wangyu. All rights reserved.
//

import UIKit
import Alamofire

class LeftVC: UIViewController {
    
    var themes:Themes?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "LeftCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "leftCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        getData(completion: {
            themes in
                self.themes = themes
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getData(completion: @escaping (Themes) -> Void) {
        let url = themes_api
        Alamofire.request(url,method:.get, parameters: nil, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    let json = JSON as! NSDictionary
                    //example if there is an id
                    let themes = Themes(fromDictionary: json)
                    completion(themes)
                case .failure(_):
                    SwiftNotice.showNoticeWithText(.error, text: "加载数据失败", autoClear: true, autoClearTime: 3000)
                }
        }
    }

}

extension LeftVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let index = self.themes?.others?.count{
            return index
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let other = self.themes!.others[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "leftCell", for: indexPath) as! LeftCell
        let title = other.name
        cell.data = other
        cell.theme_title.text = title    
        // Configure the cell...
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SwiftNotice.noticeOnStatusBar("你选中了\(themes?.others[indexPath.row].name ?? "")", autoClear: true, autoClearTime: 2000)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
