//
//  CFHomeAdCell.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CFHomeAdCell: UITableViewCell {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var adScrollView: UIScrollView!
    
    var scollArray:Array<CFCLadvertDetailModel>?
    
    var adArray: Array<CFCLadvertDetailModel>?{
        
        didSet{
            if adArray != nil{
                showData()
                scollArray = adArray
            }
            
            if adArray == nil{
                adArray = scollArray
                showData()
            }
            
            
        }
        
    }
    
    func showData(){
        
        
        let cnt = adArray?.count
        if cnt > 0{
            
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
                
                let model = adArray![i]
                
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
            
            adScrollView.pagingEnabled = true
            adScrollView.delegate = self
            
        }
        
        
        
    }
    
    class func createHomeAdCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withModel model: CFHomePageModel) ->CFHomeAdCell{
        let cellId = "homeAdCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CFHomeAdCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("CFHomeAdCell", owner: nil, options: nil).last as? CFHomeAdCell
        }
        
        
        cell?.adArray = model.datas?.cardList![0].advert
        
        
        return cell!
        
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension CFHomeAdCell: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        pageControl.currentPage = index
    }
    
    
}












