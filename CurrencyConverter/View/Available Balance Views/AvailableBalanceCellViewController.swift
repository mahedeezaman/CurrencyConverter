//
//  AvailableBalanceCellViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 28/09/2022.
//

import UIKit

class AvailableBalanceCellViewController: UITableViewCell {

    @IBOutlet weak var cellViewContainer: UIStackView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
