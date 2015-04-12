//
//  ViewController.swift
//  WebViewDemo
//
//  Created by Leon Zhang on 15/2/4.
//  Copyright (c) 2015年 Leon Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var webView = UIWebView(frame:self.view.bounds)
    var url = NSURL(string: "http://baidu.com")
    var request = NSURLRequest(URL: url)
    webView.loadRequest(request)
    self.view.addSubview(webView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

