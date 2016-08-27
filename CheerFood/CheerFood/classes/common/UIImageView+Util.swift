//
//  UIImageView+Util.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

extension UIImageView{
    
    class func createImageView(imageName: String?)->UIImageView{
        let imageView = UIImageView()
        if let name = imageName{
            imageView.image = UIImage(named: name)
        }
        
        return imageView
        
    }
    
}




