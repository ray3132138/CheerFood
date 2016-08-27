//
//  WebViewController.swift
//  CheerFood
//
//  Created by qianfeng on 16/8/27.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {
    
    var name: String?
    var good_id: String?
    var webView: UIWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        name = "wode"
        let label = UILabel.createLabel("\(name!)", font: UIFont.systemFontOfSize(17), textAlignment: .Center, textColor: UIColor.blackColor())
        label.frame = CGRectMake(0, 0, 60, 44)
        self.navigationItem.titleView = label
        
        //http://m.yueshichina.com/tmpl/product_detail.html?goods_id=694
        let urlString = "http://m.yueshichina.com/tmpl/product_detail.html?goods_id=%@"
        good_id = "694"
        if good_id != nil{
            let string = String(format: urlString, good_id!)
            let url = NSURL(string: string)
            let request = NSURLRequest(URL: url!)
            
            webView = UIWebView(frame: CGRectMake(0,0,kScreenWidth,kScreenHeight-64))
            
            webView?.loadRequest(request)
            view.addSubview(webView!)
            webView?.delegate = self
            
        }
        
        
        
        
    }
    
    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        //隐藏tabbar
//        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
//        let ctrl = appDele.window?.rootViewController
//        if ctrl?.isKindOfClass(MainTabBarController.self) == true {
//            let mainTabBarCtrl = ctrl as! MainTabBarController
//            mainTabBarCtrl.hideTabbar()
//        }
//    }
    
    

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



extension WebViewController: UIWebViewDelegate{
    
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        return true
    }
    
}










