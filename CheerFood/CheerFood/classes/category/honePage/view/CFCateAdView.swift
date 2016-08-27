//
//  CFCateAdView.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/21.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CFCateAdView: UIView {
    
    var clickClosure: ((String,String) -> Void)?

    private var tbView: UITableView?
    
    var model: CFCategoryModel? {
        didSet{
            
            tbView?.reloadData()
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
            make.edges.equalTo(self!)
        })
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

extension CFCateAdView: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var sectionNum = 1
        if model?.datas?.class_list?.count > 0{
            sectionNum += 1
            
            
        }
        
        
        return sectionNum
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if section == 0{
            if model?.datas?.banner?.count > 0{
                rowNum = 1
            }
        }else{
            
            if model?.datas?.class_list?.count > 0{
                rowNum += (model?.datas?.class_list?.count)!/2
                
            }
            
            
        }
        
        
        
        return rowNum
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 0.0
        if indexPath.section == 0{
            height = 300
        }else if indexPath.section == 1{
            height = 150
        }
        
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.section == 0{
            if model?.datas?.banner?.count > 0{
                
                cell = CFCateAdCell.createCateAdCellFor(tableView, atIndexPath: indexPath, withModel: model!)
            }
            
            
        }else if indexPath.section == 1{
            if model?.datas?.class_list?.count > 0{
                
                //let cateModel = model?.datas?.class_list![indexPath.row*2]
                  cell = CFCateCell.createCateCellFor(tableView, atIndexPath: indexPath, withModel: model!,cellClosure: clickClosure)
                
            }
            
            
        }
        
        
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    
    
    
}








