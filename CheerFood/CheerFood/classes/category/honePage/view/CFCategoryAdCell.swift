//
//  CFCategoryAdCell.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CFCategoryAdCell: UICollectionViewCell {
    
    @IBOutlet weak var adScrollView: UIScrollView!
    
    
    @IBOutlet weak var pageControll: UIPageControl!
    
    var bannArray: Array<CFCGbannerModel>?{
        didSet{
            showData()
        }
        
    }
    
    func showData(){
        
        

        
        
        
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
            
            pageControll.numberOfPages = cnt!
            
            adScrollView.delegate = self
            adScrollView.pagingEnabled = true
        }
        
        
        
    }

    
    class func createCollCateCellFor(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath,withModel model: CFCategoryModel)->CFCategoryAdCell{
        
        let cellId = "categoryCellId"
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as? CFCategoryAdCell
        
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("CFCateAdCell", owner: nil, options: nil).last as? CFCategoryAdCell
        }
        cell?.bannArray = model.datas?.banner
        
        
        return cell!
        
    }

    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension CFCategoryAdCell: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        pageControll.currentPage = index
    }
    
}












