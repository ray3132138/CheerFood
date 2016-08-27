//
//  CFHomeHeaderView.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/21.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CFHomeHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel.createLabel("悦食优选", font: UIFont.systemFontOfSize(17), textAlignment: .Left, textColor: UIColor.blackColor())
        label.frame = CGRectMake(60, 10, 80, 24)
        addSubview(label)
        
        let imageView = UIImageView.createImageView("headerImage")
        imageView.frame = CGRectMake(10, 10, 24, 24)
        addSubview(imageView)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}
