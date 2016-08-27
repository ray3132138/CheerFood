//
//  MainTabBarController.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    private var bgView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createViewController()
        
        
    }
    
    //MineViewController
    //CFInterestViewController
    //CategoryViewController
    //CFHomeViewController
    
    func createViewController(){
        let titleNames = ["悦食家","兴趣小组","分类","我的"]
        var ctrlNames = ["CFHomeViewController","CFInterestViewController","CategoryViewController","MineViewController"]
        
        let imageNames = ["home","community","shike","mine"]
        var vCtrlArray = Array<UINavigationController>()
        
        for i in 0..<ctrlNames.count{
            
            let ctrlName = "CheerFood." + ctrlNames[i]
            
            let cls = NSClassFromString(ctrlName) as! UIViewController.Type
            let ctrl = cls.init()
            
            let navCtrl = UINavigationController(rootViewController: ctrl)
            vCtrlArray.append(navCtrl)
            
        }
        self.viewControllers = vCtrlArray
        
        createCustomTabbar(titleNames, imageNames: imageNames)
        
        
    }
    
    func createCustomTabbar(titleNames: [String], imageNames:[String]){
        
        bgView = UIView.createView()
        bgView?.backgroundColor = UIColor.whiteColor()
        bgView?.layer.borderWidth = 1
        bgView?.layer.borderColor = UIColor.grayColor().CGColor
        view.addSubview(bgView!)
        
        bgView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view.snp_bottom).offset(-49)
            
            
        })
        
        let width = kScreenWidth / 4.0
        for i in 0..<imageNames.count{
            let imageName = imageNames[i]
            let titleName = titleNames[i]
            
            let bgImageName = imageName + "_normal"
            let selectBgImageName = imageName + "_select"
            let btn = UIButton.createBtn(nil, bgImageName: bgImageName, selectBgImageName: selectBgImageName, target: self, action: #selector(clickBtn(_:)))
            bgView?.addSubview(btn)
            
            btn.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(width)
                make.left.equalTo(width*CGFloat(i))
                
            })
            let label = UILabel.createLabel(titleName, font: UIFont.systemFontOfSize(8), textAlignment: .Center, textColor: UIColor.grayColor())
            btn.addSubview(label)
            
            label.snp_makeConstraints(closure: { (make) in
                make.left.right.equalTo(btn)
                make.top.equalTo(btn).offset(32)
                make.height.equalTo(12)
            })
            
            btn.tag = 300+i
            label.tag = 400
            
            if i == 0{
                btn.selected = true
                label.textColor = UIColor.orangeColor()
                
            }
            
            
            
        }
       
        
        
        
    }
    
    func clickBtn(btn: UIButton){
        
        let lastBtnView = bgView!.viewWithTag(300+selectedIndex)
        if let tmpBtn = lastBtnView{
            
            let lastBtn = tmpBtn as! UIButton
            let lastView = tmpBtn.viewWithTag(400)
            if let tmpLabel = lastView{
                let lastLabel = tmpLabel as! UILabel
                lastBtn.selected = false
                lastLabel.textColor = UIColor.grayColor()
            }
            
        }
        
        let curLabelView = btn.viewWithTag(400)
        
        if let tmpLabel = curLabelView{
            let curLabel = tmpLabel as! UILabel
            btn.selected = true
            curLabel.textColor = UIColor.orangeColor()
        }
        
        selectedIndex = btn.tag - 300
        
        
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
