//
//  CateClassCell.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CateClassCell: UITableViewCell {
    
    
    var model: CFCateCoodsListModel? {
        
        didSet{
            showData()
        }
        
    }
    
    func showData(){
        //"goods_image_url": "http://yueshi.b0.upaiyun.com/product/images/201509/18104811201509/18104811f4p1nt.jpg",
        //"store_logo": "http://yueshi.b0.upaiyun.com/supplier/ckc6/201509/08163057hbu94c"
        //商品图片
        if model?.goods_image_url != nil{
            let subView = contentView.viewWithTag(100)
            if subView?.isKindOfClass(UIImageView.self) == true{
                let gImageView = subView as! UIImageView
                let url = NSURL(string: (model?.goods_image_url)!)
                gImageView.kf_setImageWithURL(url)
                
            }
            
        }
        //店铺logo
        if model?.store_logo != nil{
            let subView = contentView.viewWithTag(200)
            if subView?.isKindOfClass(UIImageView.self) == true{
                let logoImageView = subView as! UIImageView
                let url = NSURL(string: (model?.store_logo)!)
                logoImageView.kf_setImageWithURL(url)
                
            }
            
        }
        //商品名"goods_name": "瑶柱蟹粉 200g"

        
        if model?.goods_name != nil{
            let subView = contentView.viewWithTag(300)
            if subView?.isKindOfClass(UILabel.self) == true{
                let nameLabel = subView as! UILabel
                nameLabel.text = (model?.goods_name)!
            }
        }
        //desc 描述 "goods_jingle": "只为一口奢侈的甜润：封存20
        if model?.goods_jingle != nil{
            let subView = contentView.viewWithTag(400)
            if subView?.isKindOfClass(UILabel.self) == true{
                let descLabel = subView as! UILabel
                descLabel.text = (model?.goods_jingle)!
            }
        }
        //价格 :goods_price": "245.00",
        if model?.goods_price != nil{
            let subView = contentView.viewWithTag(500)
            if subView?.isKindOfClass(UILabel.self) == true{
                let priceLabel = subView as! UILabel
                priceLabel.text = "¥" + (model?.goods_price)!
            }
        }
        //已售 goods_salenum": "633"
        if model?.goods_salenum != nil{
            let subView = contentView.viewWithTag(600)
            if subView?.isKindOfClass(UILabel.self) == true{
                let saLabel = subView as! UILabel
                saLabel.text = "已售" + (model?.goods_salenum)!
            }
        }
        
        
    }
    
    class func createCateClassCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withModel model: CFCateCoodsListModel) ->CateClassCell{
        
        let cellId = "cateClassCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CateClassCell
        
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("CateClassCell", owner: nil, options: nil).last as? CateClassCell
        }
        
        cell?.model = model
        
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








