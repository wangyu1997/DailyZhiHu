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
import GTMRefresh
import ZCycleView

class HomeVC: UITableViewController {
    
    @IBOutlet var webView: UITableView!
    var datas: [Story] = []
    var cycleView: ZCycleView!
    var top_storys:[TopStory] = []
    var top_titles:[String] = []
    var top_images:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "HomeCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "homeCell")        // Uncomment the following line to preserve selection between presentations
        self.setUpTableView()
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.view.bringSubview(toFront: (self.navigationController?.navigationBar)!)
    }
    
    func setUpTableView(){
        self.tableView.pullDownToRefreshText("亲，试试下拉会刷新的")
            .releaseToRefreshText("亲，松开试试")
            .refreshSuccessText("亲，成功了")
            .refreshFailureText("亲，无果")
            .refreshingText("亲，正在努力刷新")
        self.tableView.gtm_addRefreshHeaderView {
            [weak self] in
            print("excute refreshBlock")
            self?.refresh()
        }
        
        self.tableView.gtm_addLoadMoreFooterView {
            [weak self] in
            print("excute loadMoreBlock")
            self?.loadMore()
        }
        
        self.tableView.triggerRefreshing()
        self.tableView.showsVerticalScrollIndicator = false
        
        cycleView = ZCycleView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250))
        cycleView.timeInterval = 5
        cycleView.titleNumberOfLines = 2
        cycleView.pageControlIsHidden = true
        cycleView.titleViewHeight = 60
        cycleView.titleFont = .systemFont(ofSize: 18)
        tableView.tableHeaderView = cycleView
        cycleView.didSelectedItem = {
            index in
            let story_id = self.top_storys[index].id!
            self.performSegue(withIdentifier: "showDetail", sender: story_id)
        }

    }
    
    
    func refresh() {
        refreshData()
    }
    
    func loadMore() {
        OperationQueue.main.addOperation {
            self.tableView.endLoadMore(isNoMoreData: true)
        }
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
    
    func refreshData()  {
        let url = news_api+"latest"
        Alamofire.request(url,method:.get, parameters: nil, encoding: JSONEncoding.default)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                var load_flag = false
                switch response.result {
                case .success(let JSON):
                    let json = JSON as! NSDictionary
                    //example if there is an id
                   let storys = StoryList(fromDictionary: json)
                    self.datas = storys.stories
                    load_flag = true
                    self.top_storys = storys.topStories
                    self.top_images = []
                    self.top_titles = []
                    for item in storys.topStories{
                        self.top_titles.append(item.title)
                        self.top_images.append(item.image)
                    }
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                        self.cycleView.setUrlsGroup(self.top_images, titlesGroup:self.top_titles)
                    }
                case .failure(_):
                    load_flag = false
                }
                OperationQueue.main.addOperation {
                    self.tableView.endRefreshing(isSuccess: load_flag)
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
        
        let story = self.datas[indexPath.row]
        
        self.performSegue(withIdentifier: "showDetail", sender: story.id!)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let controller = segue.destination as! NewsDetailVC
            controller.story_id = sender as? Int
        }
    }
    
}

