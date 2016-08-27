//
//  CFInterestViewController.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit
import XWSwiftRefresh
class CFInterestViewController: BaseViewController {

    private var recoView: CFInterestView?
    
    var curPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createNav()
        
        createRecoView()
        
        dowloaderData()
        
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
        self.dowloaderData()
    }
    
    func addFooter(){
        if self.recoView!.tbView?.footerView == nil{
            
            self.recoView!.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(loadMore))
        }
        
    }
    func loadMore(){
        
        self.curPage += 1
        self.dowloaderData()
    }
    
    func createRecoView(){
        self.automaticallyAdjustsScrollViewInsets = false
        recoView = CFInterestView()
        view.addSubview(recoView!)
        
        recoView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            })
        
    }
    //下载数据
    func dowloaderData(){
        
        ProgressHUD.showOnView(self.view)
        
        
        let downloader = CFDownloader()
        downloader.delegate = self
        let url = String(format: kInterestUrl, self.curPage)
        downloader.downloadWithUrl(url)
        
    }
    
    func createNav(){
        
        addNavTitle("兴趣小组")
        addNavBtn("", target: self, action: #selector(cartAction), isLeft: false)
        
        
        
    }
    //购物车:
    func cartAction(){
        
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

extension CFInterestViewController: CFDownloaderDelegate{
    
    
    func downloader(downloader: CFDownloader, didFailWithError error: NSError) {
        ProgressHUD.hideAfterFailOnView(self.view)
    }
    
    func downloader(downloader: CFDownloader, didFinishWithData data: NSData?) {
        if let jsonData = data{
//            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(str)
            
            let model = CFHomePageModel.parseModel(jsonData)
            
            dispatch_async(dispatch_get_main_queue(), {
                [weak self] in
                self!.recoView?.model = model
                
                self!.recoView?.tbView?.headerView?.endRefreshing()
                self!.recoView?.tbView?.footerView?.endRefreshing()
                //隐藏进度条
                ProgressHUD.hideAfterSuccessOnView(self!.view)
                })
                
            
        }
        
        
    }
    
}










