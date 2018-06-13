//
//  HomeCell.swift
//  DrWy
//
//  Created by wangyu on 2018/6/10.
//  Copyright © 2018 wangyu. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var picImg: UIImageView!
    @IBOutlet weak var titleConstraint: NSLayoutConstraint!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
