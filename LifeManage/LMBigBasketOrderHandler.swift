////
////  LMBigBasketOrderHandler.swift
////  LifeManage
////
////  Created by Raman Gupta on 18/07/19.
////  Copyright © 2019 Raman Gupta. All rights reserved.
////
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

class LMBigBasketOrderHandler: NSObject, LMOrderHandler, WKNavigationDelegate {
    
    var delegate: RequestPaymentDelegate?
    var wkWebView: WKWebView!
    var step = Steps.IntermediaryShoppingScreen
    
    private static var ClassnameForAddButton = "_2LV8c"
    private(set) static var BigBasketBaseURL = "https://www.bigbasket.com"
    private(set) static var BigBasketCheckoutURL = LMBigBasketOrderHandler.BigBasketBaseURL + "/co/checkout/"
    private(set) static var BigBasketQueryURL = LMBigBasketOrderHandler.BigBasketBaseURL + "/ps/?q="
    private var thingsToOrder = ["grapes", "apple", "banana"]
    private var index = 0
    
    override init() {
        super.init()
        self.wkWebView = WKWebView.init(frame: .zero, configuration: WKWebViewConfiguration())
        self.wkWebView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
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
            self.loadURL(url: LMBigBasketOrderHandler.BigBasketQueryURL + "\(self.thingsToOrder[self.index])")
            self.index += 1
        } else if (self.step == Steps.ShoppingScreen) {
            self.wkWebView.evaluateJavaScript("document.getElementsByClassName('\(LMBigBasketOrderHandler.ClassnameForAddButton)')[0].click()") { (html: Any?, error: Error?) in
                if (error == nil) {
                    if (self.index < self.thingsToOrder.count) {
                        self.loadURL(url: LMBigBasketOrderHandler.BigBasketQueryURL + "\(self.thingsToOrder[self.index])")
                        self.index += 1
                    } else {
                        self.step = Steps.CheckoutScreen
                        self.loadURL(url: LMBigBasketOrderHandler.BigBasketCheckoutURL)
                    }
                } else {
                    print(error!)
                }
            }
        } else if (self.step == Steps.CheckoutScreen) {
//            self.wkWebView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { (html: Any?, error: Error?) in
//                if (error == nil) {
//                    print(html!)
//                } else {
//                    print(error!)
//                }
//            }
            if (self.delegate != nil) {
                self.delegate!.didRequestPaymentForOrderToComplete(fromOrderHandler: self)
            }
        }
    }
    
    func loadURL(url: String?) {
        let myURL = URL(string:(url == nil ? LMBigBasketOrderHandler.BigBasketBaseURL : url!))
        let myRequest = URLRequest(url: myURL!)
        self.wkWebView.load(myRequest)
    }
    
    // This method is a mock to test the tableView
    func callTheDelegateMethod() {
        if (self.delegate != nil) {
            self.delegate!.didRequestPaymentForOrderToComplete(fromOrderHandler: self)
        }
    }
}
