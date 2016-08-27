//
//  CFCategoryModel.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/21.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit
import SwiftyJSON

class CFCategoryModel: NSObject {
    
    var code: NSNumber?
    var datas: CFCGdatasModel?
    
    class func parseModel(data: NSData) -> CFCategoryModel{
        
        let model = CFCategoryModel()
        let jsonData = JSON(data: data)
        
        model.code = jsonData["code"].number
        
        let daDict = jsonData["datas"]
        model.datas = CFCGdatasModel.parseModel(daDict)
        
        return model
        
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }

}

class CFCGdatasModel: NSObject{
    
    var banner: Array<CFCGbannerModel>?
    var class_list: Array<CFCGclassList>?
    
    class func parseModel(jsonData: JSON)->CFCGdatasModel{
        
        let model = CFCGdatasModel()
        
        let bannerArray = jsonData["banner"]
        var bArray = Array<CFCGbannerModel>()
        for (_, subjson) in bannerArray{
            
            let bannerModel = CFCGbannerModel.parseModel(subjson)
            bArray.append(bannerModel)
            
        }
        model.banner = bArray
        
        let CLArray = jsonData["class_list"]
        var cArray = Array<CFCGclassList>()
        for (_,subjson) in CLArray{
            let cModel = CFCGclassList.parseModel(subjson)
            cArray.append(cModel)
            
        }
        model.class_list = cArray
        
        
        return model
    }
    
}

class CFCGbannerModel: NSObject{
    
    var advertId: String?
    var advertTitle: String?
    var advertImg: String?
    
    var advertText: String?
    var advertUrl: String?
    var advertVideoUrl: String?
    
    var videoShareUrl: String?
    var isMark: NSNumber?
    
    class func parseModel(jsonData: JSON)->CFCGbannerModel{
        let model = CFCGbannerModel()
        
        model.advertId = jsonData["advertId"].string
        model.advertTitle = jsonData["advertTitle"].string
        model.advertImg = jsonData["advertImg"].string
        
        model.advertText = jsonData["advertText"].string
        model.advertUrl = jsonData["advertUrl"].string
        model.advertVideoUrl = jsonData["advertVideoUrl"].string
        
        model.videoShareUrl = jsonData["videoShareUrl"].string
        model.isMark = jsonData["isMark"].number
        
        return model
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
}

class CFCGclassList: NSObject{
    
    var gc_id: String?
    var gc_name: String?
    var type_id: String?
    
    var type_name: String?
    var gc_parent_id: String?
    var commis_rate: String?
    
    var gc_sort: String?
    var gc_virtual: String?
    var gc_title: String?
    
    var gc_keywords: String?
    var gc_description: String?
    var show_type: String?
    
    var image: String?
    var text: String?
    
    
    class func parseModel(jsonData: JSON)->CFCGclassList{
        
        let model = CFCGclassList()
        model.gc_id = jsonData["gc_id"].string
        model.gc_name = jsonData["gc_name"].string
        model.type_id = jsonData["type_id"].string
        
        model.type_name = jsonData["type_name"].string
        model.gc_parent_id = jsonData["gc_parent_id"].string
        model.gc_title = jsonData["gc_title"].string
        
        model.gc_keywords = jsonData["gc_keywords"].string
        model.gc_description = jsonData["gc_description"].string
        model.show_type = jsonData["show_type"].string
        
        model.image = jsonData["image"].string
        model.text = jsonData["text"].string
        
        return model
        
    }
    
    
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}




