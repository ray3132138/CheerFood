//
//  CateClassViewController.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit
import XWSwiftRefresh


class CateClassViewController: BaseViewController {
    
    private var allModel: CFCateGoodsModel?
    private var salNumModel: CFCateGoodsModel?
    private var priceModel: CFCateGoodsModel?
    //标题
    var name: String?
    //当前页数
    var curPage = 1
    //滚动视图
    var scrollView: UIScrollView?
    //商品分类
    var gc_id: String?
    //分类全部视图
    private var caView: CateClassView?
    ////分类销量视图
    private var saleNumView: CateClassView?
    //分类价格视图
    private var priceView: CateClassView?
    
    
    private var segCtrl: KTCSegmentCtrl?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.view.backgroundColor = UIColor.whiteColor()
        
        
        
        //初始化视图
        createCateClassView()
        
        createNav()
        //下载分类全部数据
        downloadCateAllData()
        //下载分类销量数据
        downloadCateSaleNumData()
        //下载分类价格数据
        downloadCatePriceData()
        
        
        addHeader()
        addFooter()
    }
    func addFooter(){
        if self.caView?.tbView?.footerView == nil{
            self.caView?.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(loadMore))
        }
        if self.saleNumView?.tbView?.footerView == nil{
            self.saleNumView?.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(loadMore))
        }
        if self.priceView?.tbView?.footerView == nil{
            self.priceView?.tbView?.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(loadMore))
        }
        
        
    }
    func loadMore(){
        self.curPage += 1
        
        downloadCateAllData()
        //下载分类销量数据
        downloadCateSaleNumData()
        //下载分类价格数据
        downloadCatePriceData()
    }
    
    
    
    
    
    func addHeader(){
        if self.caView!.tbView?.headerView == nil{
            self.caView!.tbView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(gotoFirstpage))
        }
        if self.saleNumView?.tbView?.headerView == nil{
            self.saleNumView!.tbView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(gotoFirstpage))
        }
        if self.priceView?.tbView?.headerView == nil{
            self.priceView!.tbView?.headerView = XWRefreshNormalHeader(target: self, action: #selector(gotoFirstpage))
        }
        
    }
    func gotoFirstpage(){
        self.curPage = 1
        //下载分类全部数据
        downloadCateAllData()
        //下载分类销量数据
        downloadCateSaleNumData()
        //下载分类价格数据
        downloadCatePriceData()
        
    }
    
    func createNav(){
        
        if self.name != nil{
           addNavTitle(self.name!) 
        }
        
        
        let titleView = UIView(frame: CGRectMake(0,64,kScreenWidth,40))
        
        view.addSubview(titleView)
        segCtrl = KTCSegmentCtrl(frame: CGRectMake(80, 0, kScreenWidth-80*2, 40), titleNames: ["全部","销量","价格"])
        
        //设置代理
        segCtrl?.delegate = self
        
        titleView.addSubview(segCtrl!)
    }
    //初始化视图
    func createCateClassView(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        scrollView = UIScrollView()
        scrollView!.pagingEnabled = true
        scrollView!.showsHorizontalScrollIndicator = false
        scrollView?.delegate = self
        view.addSubview(scrollView!)
        
        scrollView!.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            
        }
        let containerView = UIView.createView()
        scrollView?.addSubview(containerView)
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView!)
            make.height.equalTo(self!.scrollView!)
        }
        
        //添加子视图
        //1.全部
        caView = CateClassView()
        
        containerView.addSubview(caView!)
        
        caView?.snp_makeConstraints(closure: {
            (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo(containerView)
            
        })
        //2.销量
        saleNumView = CateClassView()
        containerView.addSubview(saleNumView!)
        saleNumView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((caView?.snp_right)!)
        })
        //价格
        priceView  = CateClassView()
        containerView.addSubview(priceView!)
        priceView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((saleNumView?.snp_right)!)
        })
        
        //修改容器视图大小
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(priceView!)
        }
        
        
    }
    //价格数据
    func downloadCatePriceData(){
        ProgressHUD.showOnView(self.view)
        let downloader = CFDownloader()
        downloader.delegate = self
        downloader.type = .CatePrice
        
        let urlString = "http://interface.yueshichina.com/?act=goods&op=goods_list&order=1&gc_id=%@&rank=3&curpage=%ld"
        if self.gc_id != nil{
            let url = String(format: urlString,self.gc_id!, self.curPage)
            
            downloader.downloadWithUrl(url)
        }
        
        
        
    }
    
    //销量数据
    func downloadCateSaleNumData(){
        ProgressHUD.showOnView(self.view)
        let downloader = CFDownloader()
        downloader.delegate = self
        downloader.type = .CateSaleNum
        //"rank=1" 销量
        //"rank=3" 价格从高到低
        //"rank=5" 价格从低到高
        let urlString = "http://interface.yueshichina.com/?act=goods&op=goods_list&gc_id=%@&rank=1&curpage=%ld"
        
        
        if self.gc_id != nil{
            let str = String(format: urlString, self.gc_id!, self.curPage)
            downloader.downloadWithUrl(str)
        }
        
        //kCategoryUrl
        
        
        
    }
    
    
    func downloadCateAllData(){
        ProgressHUD.showOnView(self.view)
        
        let downloader = CFDownloader()
        downloader.delegate = self
        downloader.type = .CateAll
        //kCateClass = "http://interface.yueshichina.com/?act=goods&op=goods_list&gc_id=4&curpage=1"
        let urlString = "http://interface.yueshichina.com/?act=goods&op=goods_list&gc_id=%@&curpage=%ld"
        if self.gc_id != nil{
            let url = String(format: urlString, self.gc_id!, self.curPage)
            
            downloader.downloadWithUrl(url)
        }
        
        
        
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


extension CateClassViewController: CFDownloaderDelegate{
    
    
    func downloader(downloader: CFDownloader, didFailWithError error: NSError) {
        ProgressHUD.hideAfterFailOnView(self.view)
    }
    
    func downloader(downloader: CFDownloader, didFinishWithData data: NSData?) {
        
        if downloader.type == .CateAll{
            if let jsonData = data{
                let model = CFCateGoodsModel.parseModel(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if self.curPage == 1{
                        //self.caView?.model = model
                        self.allModel = model
                        self.caView?.model = self.allModel
                    }else{
                        
                        let mutableArray = NSMutableArray(array: (self.allModel!.datas?.goods_list)!)
                        mutableArray.addObjectsFromArray((model.datas?.goods_list)!)
                        let array = NSArray(array: mutableArray)
                        self.allModel!.datas?.goods_list = array as? [CFCateCoodsListModel]
                        self.caView?.model = self.allModel
                        
                    }
                    
                    ProgressHUD.hideAfterSuccessOnView(self.view)
                    //self.caView?.tbView?.headerView?.endRefreshing()
                })
                
            }
            
        }
        else if downloader.type == .CateSaleNum{
            if let jsonData = data{
                let model = CFCateGoodsModel.parseModel(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    if self.curPage == 1{
                        //self.caView?.model = model
                        self.salNumModel = model
                        self.saleNumView?.model = self.salNumModel
                    }else{
                        
                        let mutableArray = NSMutableArray(array: (self.salNumModel!.datas?.goods_list)!)
                        mutableArray.addObjectsFromArray((model.datas?.goods_list)!)
                        let array = NSArray(array: mutableArray)
                        self.salNumModel!.datas?.goods_list = array as? [CFCateCoodsListModel]
                        self.saleNumView?.model = self.salNumModel
                        
                    }
                    
                    
                    ProgressHUD.hideAfterSuccessOnView(self.view)
                })
                
            }
            
        }else if downloader.type == .CatePrice{
            if let jsonData = data{
                let model = CFCateGoodsModel.parseModel(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    
                    if self.curPage == 1{
                        //self.caView?.model = model
                        self.priceModel = model
                        self.priceView?.model = self.priceModel
                    }else{
                        
                        let mutableArray = NSMutableArray(array: (self.priceModel!.datas?.goods_list)!)
                        mutableArray.addObjectsFromArray((model.datas?.goods_list)!)
                        let array = NSArray(array: mutableArray)
                        self.priceModel!.datas?.goods_list = array as? [CFCateCoodsListModel]
                        self.priceView?.model = self.priceModel
                        
                    }
                    
                    ProgressHUD.hideAfterSuccessOnView(self.view)
                    
                })
                
            }
            
        }
        
        
        
    }
    
    
    
}

extension CateClassViewController: KTCSegmentCtrlDelegate{
    
    func didSelectSegCtrl(segCtrl: KTCSegmentCtrl, atIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(kScreenWidth*CGFloat(index), 0), animated: true)
    }
}


extension CateClassViewController: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        //修改标题选中的按钮
        segCtrl?.selectIndex = index
    }
    
}









