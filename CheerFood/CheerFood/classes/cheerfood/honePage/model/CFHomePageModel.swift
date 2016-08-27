//
//  CFHomePageModel.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit
import SwiftyJSON

class CFHomePageModel: NSObject {
    
    var code: NSNumber?
    var hasmore: Bool?
    var page_total: NSNumber?
    var datas:CFdatasModel?
    
    class func parseModel(data: NSData) -> CFHomePageModel{
        let model = CFHomePageModel()
        
        let jsonData = JSON(data: data)
        model.code = jsonData["code"].number
        model.hasmore = jsonData["hasmore"].bool
        model.page_total = jsonData["page_total"].number
        
        let dataDict = jsonData["datas"]
        model.datas = CFdatasModel.psrseModel(dataDict)
        
        
        return model
    }
    

}

class CFdatasModel: NSObject{
    var cardList:Array<CFCLadvertModel>?
    
    
    class func psrseModel(jsonData: JSON)->CFdatasModel{
        let model = CFdatasModel()
        
        var cArray = Array<CFCLadvertModel>()
        let dataArray = jsonData["cardList"]
        for (_,subjson) in dataArray{
            let cModel = CFCLadvertModel.parseModel(subjson)
            cArray.append(cModel)
            
        }
        model.cardList = cArray
        
        return model
        
    }
}



class  CFCLadvertModel: NSObject {
    
    var id: NSNumber?
    var cardName: String?
    var cardIcon: String?
    
    var cardIntrod: String?
    var cardTpl: NSNumber?
    var advert: Array<CFCLadvertDetailModel>?
    
    var productList: String?
    var endTime: String?
    var isMore: NSNumber?
    
    
    class func parseModel(jsonData: JSON)->CFCLadvertModel{
        
        let model = CFCLadvertModel()
        model.id = jsonData["id"].number
        model.cardName = jsonData["cardName"].string
        model.cardIcon = jsonData["cardIcon"].string
        
        model.cardIntrod = jsonData["cardIntrod"].string
        model.cardTpl = jsonData["cardTpl"].number
        
        let dataArray = jsonData["advert"]
        var dArray = Array<CFCLadvertDetailModel>()
        for (_, subjson) in dataArray{
            let adModel = CFCLadvertDetailModel.parseModel(subjson)
            dArray.append(adModel)
        }
        model.advert = dArray
        
        
        model.productList = jsonData["productList"].string
        model.endTime = jsonData["endTime"].string
        model.isMore = jsonData["isMore"].number
        
        return model
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
}







class CFCLadvertDetailModel: NSObject{
    
    var advertId: String?
    var advertTitle: String?
    var advertImg: String?
    
    var advertText: String?
    var advertUrl: String?
    var advertVideoUrl: String?
    
    var videoShareUrl: String?
    var isMark: NSNumber?
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    class func parseModel(jsonData: JSON)->CFCLadvertDetailModel{
        
        let model = CFCLadvertDetailModel()
        
        
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
    
    
    
}

















