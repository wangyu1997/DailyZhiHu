//
//  HtmlTools.swift
//  DrWy
//
//  Created by wangyu on 2018/6/12.
//  Copyright © 2018 wangyu. All rights reserved.
//

import Foundation

class HtmlTools{}

//css样式,隐藏header
var HIDE_HEADER_STYLE = "<style>div.headline{display:none;}</style>"
//css style tag,需要格式化
var NEEDED_FORMAT_CSS_TAG = "<link rel=\"stylesheet\" type=\"text/css\" href=\"%s\"/>"
// js script tag,需要格式化
var NEEDED_FORMAT_JS_TAG = "<script src=\"%s\"></script>"
var MIME_TYPE = "text/html; charset=utf-8"
var ENCODING = "utf-8"

/**
 * 根据css链接生成Link标签
 *
 * @param url String
 * @return String
 */
func createCssTag(url: String)-> String {
    return "<link rel=\"stylesheet\" type=\"text/css\" href=\"\(url)\"/>"
}

func createCssTag(urls: [String])-> String {
    var sb = ""
    for url in urls {
        sb.append(createCssTag(url: url))
    }
    return sb
}

func createJsTag(url: String)-> String {
    return "<script src=\"\(url)\"></script>"
}

func createJsTag(urls: [String])-> String {
    var sb = ""
    for url in urls {
        sb.append(createJsTag(url: url))
    }
    return sb
}

func createHtmlData(html: String, cssList: [String], jsList: [String])-> String {
    let css = createCssTag(urls:cssList)
    let js = createJsTag(urls:jsList)
    return "\(css)\(HIDE_HEADER_STYLE)\(html)\(js)"
}

