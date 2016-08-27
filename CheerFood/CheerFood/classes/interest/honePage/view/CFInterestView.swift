//
//  CFInterestView.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CFInterestView: UIView {

    //表格
    var tbView: UITableView?
    
    //显示数据
    
    var model: CFHomePageModel?{
        
        didSet{
            tbView?.reloadData()
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

extension CFInterestView: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var section = 1
        if model?.datas?.cardList?.count > 0{
            section += (model?.datas?.cardList?.count)!
        }
        
        
        return section
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        if section == 0{
            if let carList = model?.datas?.cardList{
                if let carADC = carList[0].advert{
                    
                    num = carADC.count
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
        
       if indexPath.section == 0{
            
            if model?.datas?.cardList![indexPath.section].advert?.count > 0{
                let rModel = model?.datas?.cardList![indexPath.section].advert![indexPath.row]
                cell = CFFavorCell.createCellFor(tableView, atIndextPath: indexPath, withDetailModel: rModel!)
                
            }
        }
        
        return cell
    }
    
}













