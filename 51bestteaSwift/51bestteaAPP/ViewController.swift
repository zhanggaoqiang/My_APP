//
//  ViewController.swift
//  51bestteaAPP
//
//  Created by zgq on 16/5/6.
//  Copyright © 2016年 zgq. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {

    var wk:WKWebView!
     override func viewDidLoad() {
        super.viewDidLoad()
          let statuesBarView = UIView(frame:CGRectMake(0,0,self.view.frame.size.width,20));
    
        
        let statusHeight = UIApplication.sharedApplication().statusBarFrame.height
        
        self.wk = WKWebView(frame: CGRectMake(0, statusHeight, self.view.frame.size.width, self.view.frame.size.height-statusHeight))
        self.wk.loadRequest(NSURLRequest(URL: NSURL(string: "http://m.51besttea.com")!))
        self.wk.navigationDelegate = self
        self.wk.UIDelegate = self
        self.view.addSubview(self.wk)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



private typealias wkNavigationDelegate  = ViewController
extension wkNavigationDelegate {
    //页面加载失败时调用
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print (error.debugDescription)
    }
    
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        print (error.debugDescription)
        
    }
    
    //页面开始加载时调用
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("都比")
    }
    
}



//web界面中有弹出框时调用
private typealias wkUIDelegate = ViewController
extension wkUIDelegate {
    
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        ac.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Cancel, handler: { (aa) -> Void in
            completionHandler()
        }))
        print("弹出框")
        self.presentViewController(ac, animated: true, completion: nil)
    }
}










