//
//  CFCategoryCell.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CFCategoryCell: UICollectionViewCell {
    
    
    @IBAction func clickBtn(sender: UIButton) {
    }
    
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var rightlabel: UILabel!
    
    
    var dataArray: Array<CFCGclassList>?{
        didSet{
            
            showData()
        }
        
    }
    
    func showData(){
        
        
        
        
        
        
    }
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //初始化方法
    }

}
