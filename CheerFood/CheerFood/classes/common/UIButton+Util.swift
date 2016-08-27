//
//  UIButton+Util.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

extension UIButton{
    
    class func createBtn(title: String?,bgImageName: String?,selectBgImageName: String?, target: AnyObject?, action: Selector)->UIButton{
        let btn = UIButton()
        
        if let btnTitle = title{
            btn.setTitle(btnTitle, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        if let btnBgImageName = bgImageName{
            btn.setBackgroundImage(UIImage(named: btnBgImageName), forState: .Normal)
        }
        if let btnSelectImageName = selectBgImageName{
            btn.setBackgroundImage(UIImage(named: btnSelectImageName), forState: .Selected)
        }
        
        if let btnTarget = target{
            btn.addTarget(btnTarget, action: action, forControlEvents: .TouchUpInside)
        }
        
        
        
        return btn
    }
    
    
}



