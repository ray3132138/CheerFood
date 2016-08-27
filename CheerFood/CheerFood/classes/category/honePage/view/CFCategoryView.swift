//
//  CFCategoryView.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CFCategoryView: UIView {
    
    var collView: UICollectionView?

    var model: CFCategoryModel?{
        
        didSet{
            collView?.reloadData()
        }
        
    }
    
    init(){
        super.init(frame: CGRectZero)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSizeMake(180, 150)
        
        collView?.delegate = self
        collView?.dataSource = self
        
        //注册cell
        let nib = UINib(nibName: "CFCategoryAdCell", bundle: NSBundle.mainBundle())
        collView?.registerNib(nib, forCellWithReuseIdentifier: "categoryAdCellId")
        collView?.backgroundColor = UIColor.redColor()
        
        
        collView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        
        addSubview(collView!)
        
        //约束
        collView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
        })
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    

}

extension CFCategoryView: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        var sectionNum = 1
        if model?.datas?.class_list?.count > 0{
            sectionNum = 2
        }
        
        return sectionNum
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemNum = 0
        if section == 0{
            if  model?.datas?.banner?.count > 0 {
                itemNum = 1
            }
        }else{
            itemNum = 2
        }
        
        
        return itemNum
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if indexPath.section == 0{
            
            cell = CFCategoryAdCell.createCollCateCellFor(collectionView, cellForItemAtIndexPath: indexPath, withModel: model!)
        }
        
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(10, 0, 10, 10)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeMake(375, 300)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(180, 100)
    }
    //两个cell的横向间距
    //minimumInteritemSpacingForSectionAtIndex
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    //两个cell的纵向间距
    //minimumLineSpacingForSectionAtIndex
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    
}
















