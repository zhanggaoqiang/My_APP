//
//  ViewController.swift
//  51bestteaAPP
//
//  Created by zgq on 16/5/6.
//  Copyright © 2016年 zgq. All rights reserved.
//

import UIKit
import WebKit



private typealias wkNavigationDelegate  = ViewController
extension wkNavigationDelegate {
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print (error.debugDescription)
        }
    
    
    func webView(webView: WKWebView, didFailNavigation navigation: WKNavigation!, withError error: NSError) {
        print (error.debugDescription)
        
    }
    
}


private typealias wkUIDelegate = ViewController
extension wkUIDelegate {
    
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (aa) -> Void in
            completionHandler()
        }))
        self.presentViewController(ac, animated: true, completion: nil)
    }
}




class ViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {

    var wk:WKWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wk = WKWebView(frame: self.view.frame)
        self.wk.loadRequest(NSURLRequest(URL: NSURL(string: "http://m.51besttea.com")!))
        self.wk.navigationDelegate = self
        self.wk.UIDelegate = self
        self.view.addSubview(self.wk)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}














