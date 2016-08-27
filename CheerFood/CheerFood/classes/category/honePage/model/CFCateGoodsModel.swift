//
//  CFCateGoodsModel.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit
import SwiftyJSON

//分类 不同类别商品  土产之家
class CFCateGoodsModel: NSObject {
    var code: NSNumber?
    var hasmore: Bool?
    var page_total: NSNumber?
    var datas: CFCateGoodsDatasModel?
    
    
    class func parseModel(data: NSData)->CFCateGoodsModel{
        let model = CFCateGoodsModel()
        let jsonData = JSON(data: data)
        
        let dataDict = jsonData["datas"]
        
        model.datas = CFCateGoodsDatasModel.parseModel(dataDict)
        
        
        return model
    }
    
    
}

class CFCateGoodsDatasModel: NSObject{
    
    var goods_list: Array<CFCateCoodsListModel>?
    
    var goods_class: Array<CFGateGoodsClassModel>?
    
    class func parseModel(jsonData: JSON)->CFCateGoodsDatasModel{
        let model = CFCateGoodsDatasModel()
        
        var arrayList = Array<CFCateCoodsListModel>()
        for (_,subjson) in jsonData["goods_list"]{
            let lisModel = CFCateCoodsListModel.parseModel(subjson)
            arrayList.append(lisModel)
        }
        model.goods_list = arrayList
        
        var arrayClass = Array<CFGateGoodsClassModel>()
        for (_,subjson) in jsonData["goods_class"]{
            let classModel = CFGateGoodsClassModel.parseModel(subjson)
            arrayClass.append(classModel)
        }
        model.goods_class = arrayClass
        
        return model
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}

class CFCateCoodsListModel: NSObject{
    
    var evaluation_count: String?
    var evaluation_good_star: String?
    var goods_id: String?
    
    var goods_image: String?
    var goods_image_url: String?
    var goods_jingle: String?
    
    var goods_marketprice: String?
    var goods_name: String?
    var goods_price: String?
    
    var goods_salenum: String?
    var group_flag: Bool?
    var have_gift: String?
    
    var is_fcode: String?
    var is_own_shop: String?
    var is_presell: String?
    
    var is_virtual: String?
    var sole_flag: Bool?
    var store_id: String?
    
    var store_logo: String?
    var store_name: String?
    var xianshi_flag: Bool?
    
    
    class func parseModel(jsonData: JSON)->CFCateCoodsListModel{
        let model = CFCateCoodsListModel()
        
        model.evaluation_count = jsonData["evaluation_count"].string
        model.evaluation_good_star = jsonData["evaluation_good_star"].string
        model.goods_id = jsonData["goods_id"].string
        
        model.goods_image = jsonData["goods_image"].string
        model.goods_image_url = jsonData["goods_image_url"].string
        model.goods_jingle = jsonData["goods_jingle"].string
        
        model.goods_marketprice = jsonData["goods_marketprice"].string
        model.goods_name = jsonData["goods_name"].string
        model.goods_price = jsonData["goods_price"].string
        
        model.goods_salenum = jsonData["goods_salenum"].string
        model.group_flag = jsonData["group_flag"].bool          //Bool
        model.have_gift = jsonData["have_gift"].string
        
        model.is_fcode = jsonData["is_fcode"].string
        model.is_own_shop = jsonData["is_own_shop"].string
        model.is_presell = jsonData["is_presell"].string
        
        model.is_virtual = jsonData["is_virtual"].string
        model.sole_flag = jsonData["sole_flag"].bool            //Bool
        model.store_id = jsonData["store_id"].string
       
        model.store_logo = jsonData["store_logo"].string
        model.store_name = jsonData["store_name"].string
        model.xianshi_flag = jsonData["xianshi_flag"].bool      //Bool
        
        return model
    }
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

class CFGateGoodsClassModel: NSObject{
    
    var gc_id: String?
    var gc_name: String?
    var child: String?
    
    class func parseModel(jsonData: JSON)->CFGateGoodsClassModel{
        
        let model = CFGateGoodsClassModel()
        model.gc_id = jsonData["gc_id"].string
        model.gc_name = jsonData["gc_name"].string
        model.child = jsonData["child"].string
        
        return model
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
}













