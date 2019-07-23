//
//  LMOrderHandler.swift
//  LifeManage
//
//  Created by Raman Gupta on 22/07/19.
//  Copyright © 2019 Raman Gupta. All rights reserved.
//

import UIKit
import WebKit

protocol LMOrderHandler {
    
    var delegate : RequestPaymentDelegate? {get set}
    
    var wkWebView: WKWebView! {get}
    
    func loadURL(url: String?)
}
