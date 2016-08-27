//
//  CFCateAdCell.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/21.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CFCateAdCell: UITableViewCell {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var adScrollView: UIScrollView!
    
    var bannArray: Array<CFCGbannerModel>?{
        didSet{
            if bannArray?.count > 0{
                showData()
            }
            
        }
        
    }
    
    func showData(){
        //删除之前的子视图
        for sub in adScrollView.subviews {
            sub.removeFromSuperview()
        }
        
        
        
        let cnt = bannArray?.count
        if cnt > 0 {
            
            let containerView = UIView.createView()
            adScrollView.addSubview(containerView)
            containerView.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                
                make.edges.equalTo(self!.adScrollView)
                make.height.equalTo(self!.adScrollView)
            })
            
            var lastView: UIView? = nil
            for i in 0..<cnt!{
                
                let model = bannArray![i]
                let tmpImageView = UIImageView.createImageView(nil)
                let url = NSURL(string: model.advertImg!)
                
                tmpImageView.kf_setImageWithURL(url)
                containerView.addSubview(tmpImageView)
                
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(kScreenWidth)
                    if i == 0{
                        make.left.equalTo(containerView)
                        
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                    
                })
                
                lastView = tmpImageView
                
            }
            
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            })
            
            pageControl.numberOfPages = cnt!
            
            adScrollView.delegate = self
            adScrollView.pagingEnabled = true
        }
        
        
        
    }
    
    
    class func createCateAdCellFor(tableView: UITableView, atIndexPath  indexPath: NSIndexPath, withModel model: CFCategoryModel)->CFCateAdCell{
        
        let cellID = "cateAdCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? CFCateAdCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("CFCateAdCell", owner: nil, options: nil).last as? CFCateAdCell
        }
        cell?.bannArray = model.datas?.banner
        
        
        return cell!
    }
    
    
//    class func createCollCateCellFor(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath,withModel model: CFCategoryModel)->CFCategoryCell{
//        
//        let cellId = "categoryCellId"
//        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as? CFCategoryCell
//        
//        if cell == nil{
//            cell = NSBundle.mainBundle().loadNibNamed("CFCateAdCell", owner: nil, options: nil).last as? CFCategoryCell
//        }
//        
//        cell.
//        
//        return cell!
//        
//    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CFCateAdCell: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        pageControl.currentPage = index
    }
    
}








