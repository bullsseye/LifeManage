////
////  LMBigBasketOrderHandler.swift
////  LifeManage
////
////  Created by Raman Gupta on 18/07/19.
////  Copyright © 2019 Raman Gupta. All rights reserved.
////
//
//import UIKit
//import WebKit
//
//enum Steps:Int {
//    case LoginScreen = 1
//    case IntermediateScreen = 2
//    case OTPOrPasswordScreen = 4
//    case ChangePasswordScreen = 8
//    case ChangePasswordComplete = 16
//}
//
//class LMBigBasketOrderHandler: NSObject, WKNavigationDelegate {
//    var wkWebView: WKWebView!
//    var step = Steps.LoginScreen
//    
//    init(wkWebView: WKWebView) {
//        super.init()
////        self.wkWebView = WKWebView.init(frame: .zero, configuration: WKWebViewConfiguration())
//        self.wkWebView = wkWebView
//        self.wkWebView.navigationDelegate = self
//    }
//    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {// document.getElementById('otpEmail').value='ramanatnsit@yahoo.com'
//        // document.documentElement.outerHTML.toString()
//        if (self.step == Steps.LoginScreen) {
//            self.wkWebView.evaluateJavaScript("document.getElementsByClassName('sc-bZQynM kdcWUz')[0].value='ramanatnsit@yahoo.com'") { (html: Any?, error: Error?) in
//                if (error == nil) {
//                    self.wkWebView.evaluateJavaScript("document.getElementsByClassName('sc-kAzzGY hmSMbA')[0].click()", completionHandler: { (html: Any?, error: Error?) in
//                        if (error == nil) {
//                            print(html)
//                        } else {
//                            print(error)
//                        }
//                    })
//                } else {
//                    // Maybe we are at the wrong screen.
//                }
//            }
//        }
//    }
//    
//    func loadURL(url: String, wkWebView: WKWebView) {
//        let myURL = URL(string:url)
//        let myRequest = URLRequest(url: myURL!)
//        wkWebView.load(myRequest)
//    }
//}
