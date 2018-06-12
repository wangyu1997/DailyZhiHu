//
//  Constant.swift
//  DrWy
//
//  Created by wangyu on 2018/6/9.
//  Copyright © 2018 wangyu. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class Constant {}

let screenBounds = UIScreen.main.bounds
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let DrawerMaxWidth:CGFloat = screenWidth/8.0*6.0
let imageHeight:CGFloat = 200.0


let news_api = "https://news-at.zhihu.com/api/4/news/"

let themes_api = "https://news-at.zhihu.com/api/4/themes"

let news_detail_api = "https://news-at.zhihu.com/api/4/news/"


func GetData(url:String,completion: @escaping (Any?) -> Void) {
    Alamofire.request(url,method:.get, parameters: nil, encoding: JSONEncoding.default)
        .validate(contentType: ["application/json"])
        .responseJSON { response in
            switch response.result {
            case .success(let JSON):
                let json = JSON as! NSDictionary
                //example if there is an id
                completion(json)
            case .failure(_):
                SwiftNotice.showNoticeWithText(.error, text: "加载数据失败", autoClear: true, autoClearTime: 3)
            }
    }
}
