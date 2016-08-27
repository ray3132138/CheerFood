//
//  CateClassView.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CateClassView: UIView {

    var tbView: UITableView?
    
    var model: CFCateGoodsModel? {
        didSet{
            
            tbView?.reloadData()
            tbView?.headerView?.endRefreshing()
            tbView?.footerView?.endRefreshing()
            
            
        }
        
    }
    
    init() {
        super.init(frame: CGRectZero)
        
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        
        tbView?.separatorStyle = .None
        addSubview(tbView!)
        
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            //make.edges.equalTo(self!)
            make.top.equalTo(self!).inset(40)
            make.left.right.equalTo(self!)
            make.bottom.equalTo(self!)
            })
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


extension CateClassView: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowNum = 0
        if model?.datas?.goods_list?.count > 0{
            rowNum = (model?.datas?.goods_list?.count)!
        }
        
        
        return rowNum
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if model?.datas?.goods_list?.count > 0{
            
            let listModel = model?.datas?.goods_list![indexPath.row]
            
            cell = CateClassCell.createCateClassCellFor(tableView, atIndexPath: indexPath, withModel: listModel!)
            
            
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 450
    }
    
    
    
}














