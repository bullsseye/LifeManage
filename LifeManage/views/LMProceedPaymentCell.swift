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
    
    var delegate: RequestPaymentDelegate?
    var baseURLString: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
}
