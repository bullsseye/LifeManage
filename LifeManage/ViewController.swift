//
//  ViewController.swift
//  LifeManage
//
//  Created by Raman Gupta on 18/07/19.
//  Copyright © 2019 Raman Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    var object = LMBigBasketOrderHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

//    @IBAction func order(_ sender: Any) {
//        object.loadURL()
//    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "OrderSegue" {
//            let vc = segue.destination as! LMOrderViewController
//            self.present(vc, animated: true, completion: nil)
//            print("button pressed")
//        }
//    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "OrderSegue") {
            return true
        }
        return false
    }
    
    
}

