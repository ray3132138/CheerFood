//
//  CFHomePageView.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit



class CFHomePageView: UIView {
    
    
    
    //表格
    var tbView: UITableView?
    
    //显示数据
    
    var model: CFHomePageModel?{
        
        didSet{
            if model != nil{
                if model?.datas?.cardList?.count > 1{
                    tbView?.reloadData()
                }
                
                else if model?.datas?.cardList?.count == 1{
                    tbView?.reloadSections(NSIndexSet(index: 1), withRowAnimation: .Automatic)
                    
                }
                
            }
            
        }
        
    }
    
    init(){
        super.init(frame: CGRectZero)
        
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        
        tbView?.separatorStyle = .None
        addSubview(tbView!)
        
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
            
        })
        
        
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

extension CFHomePageView: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var section = 1
        if model?.datas?.cardList?.count > 0{
//            print(model?.datas?.cardList?.count)
            section += (model?.datas?.cardList?.count)!
            
        }
        
        
        
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        if section == 0 {
            num = 1
        }else if section == 1{
            if let carList = model?.datas?.cardList{
                if model?.datas?.cardList?.count >= 2{
                    if let carADC = carList[1].advert{
                        
                        num += carADC.count
                    }
                    
                }
                
                else if model?.datas?.cardList?.count == 1{
                    
                    if let carADC = carList[0].advert{
                        
                        num += carADC.count
                    }
                    
                }
                
                
            }
            
        }
        
        return num
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        
        
        return 300
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        //print(model?.datas?.cardList![0].advert![1])
        if indexPath.section == 0{
            if model?.datas?.cardList?.count == 2{
                
                if model?.datas?.cardList![indexPath.row].advert?.count>0{
                    
                    cell = CFHomeAdCell.createHomeAdCellFor(tableView, atIndexPath: indexPath, withModel: model!)
                    
                }
            }
            
            
        }else if indexPath.section == 1{
            
            if model?.datas?.cardList?.count == 2{
                
                if model?.datas?.cardList![indexPath.section].advert?.count > 0{
                    
                    let rModel = model?.datas?.cardList![indexPath.section].advert![indexPath.row]
                    cell = CFFavorCell.createCellFor(tableView, atIndextPath: indexPath, withDetailModel: rModel!)
                
                }
            
            
                
            }else if model?.datas?.cardList!.count == 1{
                let rModel = model?.datas?.cardList![0].advert![indexPath.row]
                cell = CFFavorCell.createCellFor(tableView, atIndextPath: indexPath, withDetailModel: rModel!)
                
                
            }
            
            
            
            
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView: UIView? = nil
        if section == 1{
            headerView = CFHomeHeaderView(frame: CGRectMake(0,0,kScreenWidth,44))
            
        }
        return headerView
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 0
        if section == 1{
            height = 44
        }
        return height
    }
    
    
    //取消粘滞性
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let h: CGFloat = 44
        
        if scrollView.contentOffset.y > h {
            scrollView.contentInset = UIEdgeInsetsMake(-h, 0, 0, 0)
        }else if scrollView.contentOffset.y > 0 {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
        
    }
    
    
    
    
    
    
}





















