//
//  MyCollectionViewCell.swift
//  hangge_1594
//
//  Created by hangge on 2017/3/16.
//  Copyright © 2017年 hangge.com. All rights reserved.
//

import UIKit

//自定义的Collection View单元格
class MyCollectionViewCell: UICollectionViewCell {
    
    //用于显示标题
    @IBOutlet weak var label: UILabel!
    
    //用于显示图片
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
