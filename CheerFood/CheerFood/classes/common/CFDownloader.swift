//
//  CFDownloader.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit
import Alamofire

public enum CFDownloaderType: Int{
    case Default = 10
    case CateAll            //分类全部
    case CateSaleNum        //分类销量
    case CatePrice          //分类价格
}

protocol CFDownloaderDelegate: NSObjectProtocol{
    func downloader(downloader:CFDownloader,didFailWithError error: NSError)
    func downloader(downloader:CFDownloader,didFinishWithData data: NSData?)
}

class CFDownloader: NSObject {
    weak var delegate: CFDownloaderDelegate?
    
    var type: CFDownloaderType = .Default
    
    
    func downloadWithUrl(urlString: String){
        
        Alamofire.request(.GET, urlString, parameters: nil, encoding: ParameterEncoding.URL, headers: nil).responseData { (response) in
            
            switch response.result{
            case .Failure(let error):
                self.delegate?.downloader(self, didFailWithError: error)
            case .Success:
                self.delegate?.downloader(self, didFinishWithData: response.data)
            }
            
            
        }
        
    }
    
    
}







