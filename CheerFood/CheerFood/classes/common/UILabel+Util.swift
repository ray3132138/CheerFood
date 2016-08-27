//
//  UILabel+Util.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

extension UILabel{
    class func createLabel(text: String?, font: UIFont?, textAlignment: NSTextAlignment?, textColor: UIColor?)->UILabel{
        let label = UILabel()
        
        if let labelText = text {
            label.text = labelText
        }
        if let labelFont = font{
            label.font = labelFont
        }
        if let labelAlignment = textAlignment{
            label.textAlignment = labelAlignment
        }
        if let labelColor = textColor{
            label.textColor = labelColor
        }
        return label
        
        
    }
    
    
}
