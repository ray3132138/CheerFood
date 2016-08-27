//
//  CategoryViewController.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController {
    //tableView做的
    private var recoView: CFCateAdView?
    
    //collView做的
    private var colView: CFCategoryView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: true)
        
        
        //导航
        createNav()
        
        createCategoryView()
        
        
        
        //下载数据
        downloadCategoryData()
        
        self.view.backgroundColor = UIColor.whiteColor()
    }
    //搜索
    func searchAction(){
        let wCtrl = WebViewController()
        self.navigationController?.pushViewController(wCtrl, animated: true)
        
    }
    
    
    func createCategoryView(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        recoView = CFCateAdView()
        view.addSubview(recoView!)
        recoView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        })
        
        
    }
    //collectionView 不显示
    func createCollCategoryView(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        colView = CFCategoryView()
        view.addSubview(colView!)
        
        colView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        })
        
    }
    
    func downloadCategoryData(){
        
        let downloader = CFDownloader()
        
        downloader.delegate = self
        
        downloader.downloadWithUrl(kCategoryUrl)
        
        
        
    }
    
    
    func createNav(){
        
        addNavTitle("分类")
        addNavBtn("", target: self, action: #selector(cartAction), isLeft: false)
        
        
        
    }
    //购物篮
    func cartAction(){
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    func gotoCatePage(gc_id: String,gc_name: String){
        
        let cCtrl = CateClassViewController()
        cCtrl.gc_id = gc_id
        cCtrl.name = gc_name
        self.navigationController?.pushViewController(cCtrl, animated: true)
        
        
    }
    

}

extension CategoryViewController: CFDownloaderDelegate{
    
    func downloader(downloader: CFDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloader(downloader: CFDownloader, didFinishWithData data: NSData?) {
        if let jsonData = data{
//            let str = NSString(data: jsonData, encoding: NSUTF8StringEncoding)
//            print(str)
            let model = CFCategoryModel.parseModel(jsonData)
            dispatch_async(dispatch_get_main_queue(), { 
                [weak self] in
                self!.recoView?.model = model
                
                self!.recoView?.clickClosure = {
                    [weak self]
                    (gc_id: String?,gc_name: String?) in
                    
                    self!.gotoCatePage(gc_id!,gc_name: gc_name!)
                    
                    
                }
                
                
            })
            
            
        }
        
    }
    
}







