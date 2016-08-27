//
//  CFHomeViewController.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit
import XWSwiftRefresh
class CFHomeViewController: BaseViewController ,CFDownloaderDelegate{
    
    private var recoView: CFHomePageView?
    
    var scollModel:NSObject?
    var scollView: UIScrollView?
    
    var curPage: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //导航
        createMyNav()
        
        //创建View
        createRecoView()
        
        //下载数据
        downloadCFHomeData()
        
        addFooter()
        addHeater()
        
        
    }
    func addHeater(){
        if self.recoView?.tbView?.headerView == nil{
            self.recoView?.tbView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(gotofirstPage))
        }
        
    }
    func gotofirstPage(){
        self.curPage = 1
        self.downloadCFHomeData()
    }
    
    func addFooter(){
        if self.recoView!.tbView?.footerView == nil{
            
            self.recoView!.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(loadMore))
        }
        
    }
    func loadMore(){
        
        self.curPage += 1
        self.downloadCFHomeData()
    }
    
    
    func createRecoView(){
        self.automaticallyAdjustsScrollViewInsets = false
        recoView = CFHomePageView()
        view.addSubview(recoView!)
        
        recoView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        })
        
        
        
    }
    
    //下载数据
    func downloadCFHomeData(){
        ProgressHUD.showOnView(self.view)
        let downloader = CFDownloader()
        downloader.delegate = self
        let url = String(format: kCheerFoodUrl, self.curPage)
        downloader.downloadWithUrl(url)
        
        
        
    }
    
    //导航
    func createMyNav(){
        addNavTitle("悦食家")
        
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: true)
        
        addNavBtn("", target: self, action: #selector(cartAction), isLeft: false)
        
    }
    //购物车
    func cartAction(){
        
    }
    
    //搜索
    func searchAction(){
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CFHomeViewController{
    func downloader(downloader: CFDownloader, didFailWithError error: NSError) {
        ProgressHUD.hideAfterFailOnView(self.view)
    }
    func downloader(downloader: CFDownloader, didFinishWithData data: NSData?) {
        
        
        if let jsonData = data{
            
//            let str = NSString(data: jsonData, encoding: NSUTF8StringEncoding)
//            print(str!)
            let model = CFHomePageModel.parseModel(jsonData)
            
            dispatch_async(dispatch_get_main_queue(), { 
                [weak self] in
                self!.recoView?.model = model
                
                if self?.recoView?.model?.datas?.cardList?.count == 1{
                    
                    
                }
                
                self?.recoView?.tbView?.footerView?.endRefreshing()
                self?.recoView?.tbView?.headerView?.endRefreshing()
                ProgressHUD.hideAfterSuccessOnView(self!.view)
            })
            
            
            
        }
        
        
    }
    
}












