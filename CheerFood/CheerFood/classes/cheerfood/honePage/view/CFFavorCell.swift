//
//  CFFavorCell.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/21.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CFFavorCell: UITableViewCell {
    
    
    var model: CFCLadvertDetailModel?{
        didSet{
            showData()
        }
        
    }
    
    func showData(){
        
        let fImageView = contentView.viewWithTag(100)
        
        let url = NSURL(string: (model?.advertImg)!)
        
        if fImageView?.isKindOfClass(UIImageView.self) == true{
            let subView = fImageView as! UIImageView
            subView.kf_setImageWithURL(url)
            
        }
        
        if model?.advertTitle != nil{
            let subView = contentView.viewWithTag(200)
            if subView?.isKindOfClass(UILabel.self) == true{
                let titleLabel = subView as! UILabel
                titleLabel.text = (model?.advertTitle)!
            }
            
        }
        
        if model?.advertText != nil{
            let subView = contentView.viewWithTag(201)
            if subView?.isKindOfClass(UILabel.self) == true{
                let descLabel = subView as! UILabel
                descLabel.text = (model?.advertText)!
                
            }
        }
        
        
        
        
    }
    
    class func createCellFor(tableView: UITableView,atIndextPath indexPath: NSIndexPath, withDetailModel dModel: CFCLadvertDetailModel)->CFFavorCell{
        
        let cellId = "favorCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CFFavorCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("CFFavorCell", owner: nil, options: nil).last as? CFFavorCell
            
        }
        cell?.model = dModel
        
        
        
        return cell!
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
