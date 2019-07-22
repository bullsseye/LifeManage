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

//    var object = LMBigBasketOrderHandler()
    // Make singleton class here for big basket order
    let repeatingTimer = LMRepeatingTimer(timeInterval: 1.0)
    
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
    
    // MARK - Order delegate methods
    func didReceiveRemoteNotificationToOrder(fromRepeatingTimer: LMRepeatingTimer, baseURLString: String) {
        // Call the api to order for bigbasket
    }
}

