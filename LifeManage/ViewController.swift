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

protocol RequestPaymentDelegate {
    func didRequestPaymentForOrderToComplete(fromOrderHandler: LMOrderHandler)
    
    func confirmOrderForPayment(fromCell: LMProceedPaymentCell, baseURLString: String)
    
    func didPlaceOrder(fromOrderViewController: LMOrderViewController, baseURLString: String)
}

extension NSNotification.Name {
    public static let PaymentDoneNotification = Notification.Name("PaymentDoneNotification")
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, OrderDelegate, RequestPaymentDelegate {
    
    private static let BigBasketOrderHandlerConst = "LMBigBasketOrderHandler"
    private static let PendingPaymentsHeading = "Pending Payments"
    

    @IBOutlet var orderTableView: UITableView!
    
    @IBOutlet var allDoneImageView: UIImageView!
    private var proceedToPaymentData = [String]()
    let repeatingTimer = LMRepeatingTimer(timeInterval: 1.0)
    
    // let urlVsObjHandlerClassString = ["www.bigbasket.com": BigBasketOrderHandlerConst]
    var urlVsObjHandler = [String: LMOrderHandler]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.orderTableView.register(UINib(nibName: "LMProceedPaymentCell", bundle: nil), forCellReuseIdentifier: "LMProceedPaymentCell")
        self.orderTableView.delegate = self
        self.orderTableView.dataSource = self
        
        self.orderTableView.backgroundColor = UIColor.clear
        self.orderTableView.isOpaque = false
        self.allDoneImageView.isHidden = true
        
        repeatingTimer.delegate = self
        repeatingTimer.resume()
    }
    
    func classFromClassName(Class: String) -> LMBigBasketOrderHandler? {
        if (Class == ViewController.BigBasketOrderHandlerConst) {
            return LMBigBasketOrderHandler()
        }
        return nil
    }
    
    // MARK - Order delegate methods
    func didReceiveRemoteNotificationToOrder(fromRepeatingTimer: LMRepeatingTimer, baseURLString: String) {
        
        var bigBasketObject = self.urlVsObjHandler[baseURLString]
        if (bigBasketObject == nil) {
            // Use checks to understand the object that needs to be created. It may not be just bigBasketHandlerObject.
            bigBasketObject = LMBigBasketOrderHandler()
            bigBasketObject?.delegate = self
            self.urlVsObjHandler[baseURLString] = bigBasketObject
        }
        // FIXME: (ramang) Use loadURL only. Remove callTheDelegateMethod, it is just for testing purpose.
//        bigBasketObject?.loadURL(url: nil)
        let obj = bigBasketObject as! LMBigBasketOrderHandler
        obj.callTheDelegateMethod()
    }
    
    // MARK - Request payment delegate method
    func didRequestPaymentForOrderToComplete(fromOrderHandler: LMOrderHandler) {
        // Think of what can be appended below
        self.proceedToPaymentData.append("bigBasket")
        self.orderTableView.reloadData()
    }
    
    func confirmOrderForPayment(fromCell: LMProceedPaymentCell, baseURLString: String) {
        // Right now I am hardcoding the checkout call. But it should be dynamic to load
        // the webpage when required
        let checkoutViewController = self.storyboard?.instantiateViewController(withIdentifier: "LMOrderViewController") as! LMOrderViewController
        // Below checkoutURL should be based on baseURLString
        checkoutViewController.urlString = LMBigBasketOrderHandler.BigBasketCheckoutURL
        checkoutViewController.delegate = self
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
    }
    
    func didPlaceOrder(fromOrderViewController: LMOrderViewController, baseURLString: String) {
        // Post a notification here with baseURLString that the order is placed.
        NotificationCenter.default.post(name: Notification.Name.PaymentDoneNotification,
                                        object: self,
                                        userInfo: ["url": LMBigBasketOrderHandler.BigBasketBaseURL])
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK - TableViewDelegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.proceedToPaymentData.count > 0) {
            self.orderTableView.backgroundView = nil
            self.allDoneImageView.isHidden = true
            self.orderTableView.isHidden = false
        } else {
            self.allDoneImageView.isHidden = false
        }
        return self.proceedToPaymentData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let proceedToPaymentCell = self.orderTableView.dequeueReusableCell(withIdentifier: "LMProceedPaymentCell", for: indexPath) as! LMProceedPaymentCell
        proceedToPaymentCell.eventLabel.text = "Groceries"
        proceedToPaymentCell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        // Right now I have hardcoded the baseURL but this data should come from the server eventually
        proceedToPaymentCell.baseURLString = LMBigBasketOrderHandler.BigBasketBaseURL
        proceedToPaymentCell.delegate = self
        return proceedToPaymentCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ViewController.PendingPaymentsHeading
    }
}

