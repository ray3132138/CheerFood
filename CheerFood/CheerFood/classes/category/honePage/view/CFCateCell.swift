//
//  CFCateCell.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/22.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CFCateCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var leftLabel: UILabel!
    
    @IBOutlet weak var rightlabel: UILabel!
    
    private var num = 0
    
    //声明闭包
    var clickClosure: ((String,String) -> Void)?
    
    
    
    @IBAction func clickLeftbtn(sender: UIButton) {
        
        
        
        let cateCtrl = CateClassViewController()
        if dataArray?.count > 0{
            let leftModel = dataArray![0]
            if leftModel.gc_id != nil{
                cateCtrl.gc_id = leftModel.gc_id!
                cateCtrl.name = leftModel.gc_name
                clickClosure!(cateCtrl.gc_id!,cateCtrl.name!)
            }
            
        }
        
        
        
        
        
    }
    
    
    
    @IBAction func clickRightBtn(sender: UIButton) {
        let cateCtrl = CateClassViewController()
        if dataArray?.count > 1{
            let rightModel = dataArray![1]
            if rightModel.gc_id != nil{
                cateCtrl.gc_id = rightModel.gc_id
                cateCtrl.name = rightModel.gc_name
                clickClosure!(cateCtrl.gc_id!,cateCtrl.name!)
            }
            
            
        }
        
       
    }
    
    
    
    var dataArray: Array<CFCGclassList>?{
        didSet{
            
            showData()
            
        }
    }
    
    func showData(){
        
     
        
        if dataArray?.count > 0{
            let leftModel = dataArray![0]
                
            let url = NSURL(string: leftModel.image!)
            leftImageView.kf_setImageWithURL(url)
            leftLabel.text = leftModel.gc_name!
            
        }
        
        if dataArray?.count > 1{
            let rightModel = dataArray![1]
            let url = NSURL(string: rightModel.image!)
            rightImageView.kf_setImageWithURL(url)
            rightlabel.text = rightModel.gc_name!
        }
        
        
        
    }
    
    
    class func createCateCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withModel model: CFCategoryModel,cellClosure: ((String,String) -> Void)?)->CFCateCell{
        let cellId = "categoryCellid"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CFCateCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("CFCateCell", owner: nil, options: nil).last as? CFCateCell
            
        }
        
        if model.datas?.class_list?.count >= (indexPath.row*2+2){
            let array = NSArray(array: (model.datas?.class_list)!)
            let curArray = array.subarrayWithRange(NSMakeRange(indexPath.row*2, 2))
            cell?.dataArray = curArray as? Array<CFCGclassList>
            
            //点击事件
            cell?.clickClosure = cellClosure
        }
        
        
        return cell!
        
        
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .None
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
