//
//  LMProceedPaymentCell.swift
//  LifeManage
//
//  Created by Raman Gupta on 22/07/19.
//  Copyright © 2019 Raman Gupta. All rights reserved.
//

import UIKit

class LMProceedPaymentCell: UITableViewCell {
    @IBOutlet var eventLabel: UILabel!
    @IBOutlet var img: UIImageView!
    @IBOutlet var payButton: UIButton!
    
    var delegate: RequestPaymentDelegate?
    var baseURLString: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NotificationCenter.default.addObserver(self, selector: #selector(didCompletePayment), name: Notification.Name.PaymentDoneNotification, object: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func pay(_ sender: Any) {
        assert(self.baseURLString != nil)
        assert(self.delegate != nil)
        self.delegate!.confirmOrderForPayment(fromCell: self, baseURLString: self.baseURLString!)
    }
    
    @objc func didCompletePayment(_ notification: Notification) {
        let urlString: String? = notification.userInfo?["url"] as! String?
        if (urlString != nil && urlString! == self.baseURLString) {
//            let imageView = UIImageView.init(image: UIImage.init(named: "done"))
            self.img.image = UIImage.init(named: "done")
            self.payButton.isEnabled = false
            self.payButton.setTitle("Paid", for: UIControl.State.disabled)
            self.img.setNeedsDisplay()
            self.img.setNeedsLayout()
            self.imageView?.setNeedsDisplay()
            self.imageView?.setNeedsLayout()
        }
    }
}
