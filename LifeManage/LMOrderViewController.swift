//
//  LMOrderViewController.swift
//  LifeManage
//
//  Created by Raman Gupta on 20/07/19.
//  Copyright © 2019 Raman Gupta. All rights reserved.
//

import UIKit
import WebKit

enum Steps:Int {
    case LoginScreen = 1
    case OTPOrPasswordScreen = 2
    case IntermediaryShoppingScreen = 4
    case ShoppingScreen = 8
    case CheckoutScreen = 16
}

class LMOrderViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var wkWebView: WKWebView!
    var step = Steps.IntermediaryShoppingScreen
    
    private static var ClassnameForAddButton = "_2LV8c"
    private static var BigBasketBaseURL = "https://www.bigbasket.com"
    private static var BigBasketCheckoutURL = LMOrderViewController.BigBasketBaseURL + "/co/checkout/"
    private static var BigBasketQueryURL = LMOrderViewController.BigBasketBaseURL + "/ps/?q="
    private var thingsToOrder = ["grapes", "apple", "banana"]
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wkWebView.navigationDelegate = self
        self.loadURL(url: LMOrderViewController.BigBasketBaseURL, wkWebView: self.wkWebView)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // document.documentElement.outerHTML.toString()
        if (self.step == Steps.LoginScreen) {
            self.wkWebView.evaluateJavaScript("document.getElementsByClassName('sc-bZQynM kdcWUz')[0].value='ramanatnsit@yahoo.com'") { (html: Any?, error: Error?) in
                if (error == nil) {
                    self.wkWebView.evaluateJavaScript("document.getElementsByClassName('sc-kAzzGY hmSMbA')[0].click()", completionHandler: { (html: Any?, error: Error?) in
                        if (error == nil) {
                            print(html!)
                        } else {
                            print(error!)
                        }
                    })
                } else {
                    print(error!)
                }
            }
        } else if (self.step == Steps.OTPOrPasswordScreen) {
            self.step = Steps.IntermediaryShoppingScreen
        } else if (self.step == Steps.IntermediaryShoppingScreen) {
            self.step = Steps.ShoppingScreen
            self.loadURL(url: LMOrderViewController.BigBasketQueryURL + "\(self.thingsToOrder[self.index])", wkWebView: self.wkWebView)
            self.index += 1
        } else if (self.step == Steps.ShoppingScreen) {
            self.wkWebView.evaluateJavaScript("document.getElementsByClassName('\(LMOrderViewController.ClassnameForAddButton)')[0].click()") { (html: Any?, error: Error?) in
                if (error == nil) {
                    if (self.index < self.thingsToOrder.count) {
                        self.loadURL(url: LMOrderViewController.BigBasketQueryURL + "\(self.thingsToOrder[self.index])", wkWebView: self.wkWebView)
                        self.index += 1
                    } else {
                        self.step = Steps.CheckoutScreen
                        self.loadURL(url: LMOrderViewController.BigBasketCheckoutURL, wkWebView: self.wkWebView)
                    }
                } else {
                    print(error!)
                }
            }
        } else if (self.step == Steps.CheckoutScreen) {
            self.wkWebView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html: Any?, error: Error?) in
                if (error == nil) {
                    print(html!)
                } else {
                    print(error!)
                }
            }
        }
    }
    
    func loadURL(url: String, wkWebView: WKWebView) {
        let myURL = URL(string:url)
        let myRequest = URLRequest(url: myURL!)
        wkWebView.load(myRequest)
    }
}
