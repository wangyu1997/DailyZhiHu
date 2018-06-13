//
//  ParallaxHeaderView.swift
//  DrWy
//
//  Created by wangyu on 2018/6/13.
//  Copyright © 2018 wangyu. All rights reserved.
//

import UIKit

class ParallaxHeaderView: UIView {
    
    var subView: UIView
    var contentView:UIView = UIView()
    var maxOffsetY: CGFloat
    var delegate:ParallaxHeaderViewDelegate
    
    init(subview:UIView,headerViewSize: CGRect, maxOffsetY: CGFloat, delegate: ParallaxHeaderViewDelegate) {
        self.subView = subview
        self.maxOffsetY = maxOffsetY < 0 ? maxOffsetY : -maxOffsetY
        self.delegate = delegate

        super.init(frame: headerViewSize)
        self.subView.autoresizingMask = [.flexibleLeftMargin,.flexibleRightMargin,.flexibleTopMargin,.flexibleBottomMargin,.flexibleWidth,.flexibleHeight]
        self.clipsToBounds = false

        self.contentView.frame = self.bounds
        self.contentView.addSubview(subView)
        self.contentView.clipsToBounds = true
        self.addSubview(contentView)
    }
    
    
    func layoutHeaderViewWhenScroll(offset: CGPoint) {
        
        if offset.y < maxOffsetY {
            self.delegate.LockScorllView(maxOffsetY: maxOffsetY)
        }else {
            var delta:CGFloat = 0.0
            var rect = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            
            delta = offset.y
            rect.origin.y += delta ;
            rect.size.height -= delta;
            
            self.contentView.frame = rect;
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


protocol ParallaxHeaderViewDelegate: class {
    func LockScorllView(maxOffsetY: CGFloat)
}
//这个的意思是，对协议进行扩展，任何遵守此协议的UITableViewController都由默认的实现方法
extension ParallaxHeaderViewDelegate where Self : UITableViewController {
    func LockScorllView(maxOffsetY: CGFloat) {
        self.tableView.contentOffset.y = maxOffsetY
    }
}

