//
//  LeftCell.swift
//  DrWy
//
//  Created by wangyu on 2018/6/11.
//  Copyright © 2018 wangyu. All rights reserved.
//

import UIKit

class LeftCell: UITableViewCell {
    
    @IBOutlet weak var theme_title: UILabel!
    var data:Other?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func follow_action(_ sender: UIButton) {
        SwiftNotice.noticeOnStatusBar("你follow了\(data?.name! ?? "")", autoClear: true, autoClearTime: 2000)
    }
    
}
