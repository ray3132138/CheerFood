//
//  BaseViewController.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/20.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
    func addNavTitle(title: String){
        
        let titleLabel = UILabel.createLabel(title, font: UIFont.systemFontOfSize(20), textAlignment: .Center, textColor: UIColor.blackColor())
        
        titleLabel.frame = CGRectMake(0, 0, 20, 20)
        self.navigationItem.titleView = titleLabel
        
        
    }
    func addNavBtn(imageName: String, target: AnyObject?, action: Selector, isLeft: Bool){
        
        let btn = UIButton.createBtn(nil, bgImageName: imageName, selectBgImageName: nil, target: target, action: action)
        
        btn.frame = CGRectMake(0, 4, 40, 36)
        let barBtnItem = UIBarButtonItem(customView: btn)
        
        if isLeft{
            navigationItem.leftBarButtonItem = barBtnItem
            
        }else{
            navigationItem.rightBarButtonItem = barBtnItem
            
        }
        
        
        
    }
    
    func addNavBackBtn(){
        
        addNavBtn("nav_back_black", target: self, action: #selector(backAction), isLeft: true)
    }
    func backAction(){
        navigationController?.popViewControllerAnimated(true)
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
