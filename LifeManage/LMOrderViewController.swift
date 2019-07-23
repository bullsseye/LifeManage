//
//  LMOrderViewController.swift
//  LifeManage
//
//  Created by Raman Gupta on 20/07/19.
//  Copyright © 2019 Raman Gupta. All rights reserved.
//

import UIKit
import WebKit

class LMOrderViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var wkWebView: WKWebView!
    var urlString: String?
    var delegate: RequestPaymentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wkWebView.navigationDelegate = self
        assert(self.urlString != nil)
        self.loadURL(url: self.urlString!)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        assert(self.delegate != nil)
        assert(self.urlString != nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.delegate!.didPlaceOrder(fromOrderViewController: self, baseURLString: self.urlString!)
        })
    }
    
    func loadURL(url: String) {
        let myURL = URL(string:url)
        let myRequest = URLRequest(url: myURL!)
        self.wkWebView.load(myRequest)
    }
}
