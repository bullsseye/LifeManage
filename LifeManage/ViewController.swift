//
//  ViewController.swift
//  LifeManage
//
//  Created by Raman Gupta on 18/07/19.
//  Copyright © 2019 Raman Gupta. All rights reserved.
//

import UIKit

protocol OrderDelegate {
    func didReceiveRemoteNotificationToOrder(fromRepeatingTimer: LMRepeatingTimer, baseURLString: String)
}

class ViewController: UIViewController, OrderDelegate {
    
    private static let BigBasketOrderHandlerConst = "LMBigBasketOrderHandler"
    private static var BigBasketBaseURL = "https://www.bigbasket.com"
    
    // Make singleton class here for big basket order
    let repeatingTimer = LMRepeatingTimer(timeInterval: 1.0)
//    let urlVsObjHandlerClassString = ["www.bigbasket.com": BigBasketOrderHandlerConst]
    var urlVsObjHandler = [String: LMBigBasketOrderHandler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        repeatingTimer.delegate = self
        repeatingTimer.resume()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "OrderSegue") {
            return true
        }
        return false
    }
    
    func classFromClassName(Class: String) -> LMBigBasketOrderHandler? {
        if (Class == ViewController.BigBasketOrderHandlerConst) {
            return LMBigBasketOrderHandler()
        }
        return nil
    }
    
    // MARK - Order delegate methods
    func didReceiveRemoteNotificationToOrder(fromRepeatingTimer: LMRepeatingTimer, baseURLString: String) {
        // Call the api to order for bigbasket
        var bigBasketObject = self.urlVsObjHandler[baseURLString]
        if (bigBasketObject == nil) {
            bigBasketObject = LMBigBasketOrderHandler()
            self.urlVsObjHandler[baseURLString] = bigBasketObject
        }
        bigBasketObject?.loadURL(url: ViewController.BigBasketBaseURL)
    }
}

