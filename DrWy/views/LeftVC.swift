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
        setUpHeaderView()
        getData(completion: {
            themes in
            self.themes = themes
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        })
        
        // Do any additional setup after loading the view.
    }
    
    func setUpHeaderView(){
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 45))
        let rightButton =  UIButton(type: .custom)
        rightButton.setImage(UIImage(named: "Menu_Enter"), for: .normal)
        rightButton.frame = CGRect(x: headerView.center.x+40-22/2.0, y: headerView.center.y-22/2.0, width: 22, height:22)
        let homeButton = UIButton(type: .custom)
        homeButton.setImage(UIImage(named: "Menu_Icon_Home"), for: .normal)
        homeButton.frame = CGRect(x: 30, y: headerView.center.y-25/2.0, width: 25, height:25)
        let title = UILabel(frame: CGRect(x: 30+homeButton.bounds.width+10, y: headerView.center.y-40/2.0, width: 80, height: 40))
        title.text = "首页"
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 17)
        headerView.addSubview(rightButton)
        headerView.addSubview(homeButton)
        headerView.addSubview(title)
        let tap =  UITapGestureRecognizer(target: self, action: #selector(tap_index(_:)))
        headerView.addGestureRecognizer(tap)
        self.tableView.tableHeaderView = headerView
    }
    
    @objc func tap_index(_ sender:UITapGestureRecognizer){
        let mainVc = (DrawerMainVC.drawerVC?.mainVC as! UINavigationController).visibleViewController as! HomeVC
        mainVc.setDataAndRefresh(url:news_api+"latest", is_cover_page: true)
        DrawerMainVC.drawerVC?.closeSideBar()
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
                    SwiftNotice.showNoticeWithText(.error, text: "加载数据失败", autoClear: true, autoClearTime: 3)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "leftCell", for: indexPath) as! LeftCell
        var title:String
        let other = self.themes!.others[indexPath.row]
        title = other.name
        cell.data = other
        
        cell.theme_title.text = title    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainVc = (DrawerMainVC.drawerVC?.mainVC as! UINavigationController).visibleViewController as! HomeVC
        mainVc.setDataAndRefresh(url: theme_list_api+"\(self.themes?.others[indexPath.row].id! ?? 0)", is_cover_page: false)
        DrawerMainVC.drawerVC?.closeSideBar()
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}
