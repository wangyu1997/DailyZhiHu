//
//  NewsDetailVC.swift
//  DrWy
//
//  Created by wangyu on 2018/6/12.
//  Copyright © 2018 wangyu. All rights reserved.
//

import UIKit
import Alamofire

class NewsDetailVC: UIViewController {
    
    var story_id:Int!
    var newsDetail:NewsDetailNormal!
    @IBOutlet weak var webview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWebView()
        let url = "\(news_detail_api)\(story_id!)"
        print(url)
        SwiftNotice.load()
        GetData(url:url,completion: {
            (json) in
            self.newsDetail = NewsDetailNormal(fromDictionary: json! as! NSDictionary)
            let body_html = createHtmlData(html: self.newsDetail.body!, cssList: self.newsDetail.css!, jsList: self.newsDetail.js!)
            self.webview.loadHTMLString(body_html, baseURL: nil)
            SwiftNotice.clear()
        })
        
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.view.sendSubview(toBack: (self.navigationController?.navigationBar)!)
        // Do any additional setup after loading the view.
    }
    
    func setUpWebView() {
        self.webview.backgroundColor = .clear
        for subview in  self.webview.subviews
        {
            if subview.isKind(of: UIScrollView.self)
            {
                let sub_scroll = subview as! UIScrollView
                sub_scroll.showsVerticalScrollIndicator = false
                for in_scroll_view in sub_scroll.subviews
                {
                    if in_scroll_view.isKind(of: UIImageView.self)
                    {
                        in_scroll_view.isHidden = true
                    }
                }
            }
        }

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
