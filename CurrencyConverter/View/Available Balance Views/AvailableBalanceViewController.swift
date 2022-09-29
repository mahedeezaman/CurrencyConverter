//
//  AvailableBalanceViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 28/09/2022.
//

import UIKit

protocol ConvertedValue: AnyObject {
    func valueChanged(of currency: String, amount: String)
}

class AvailableBalanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dummyData : [String : String] = [:]
    
    @IBOutlet weak var balanceTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        balanceTableView.backgroundColor = ColorConstants.homeViewContainersColor
        balanceTableView.layer.cornerRadius = Constants.cornerRadius
        balanceTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        balanceTableView.separatorColor = .clear
        
        balanceTableView.allowsSelection = false
        
        balanceTableView.dataSource = self
        balanceTableView.delegate = self
        
        balanceTableView.registerCell(type: AvailableBalanceCellViewController.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: AvailableBalanceCellViewController.self, for: indexPath) else {
            return UITableViewCell()
        }
        
        let index = dummyData.index(dummyData.startIndex, offsetBy: indexPath.row)
        
        cell.backgroundColor = .clear
        cell.cellViewContainer.backgroundColor = ColorConstants.homeViewBackground
        
        cell.currencyLabel.text = dummyData.keys[index]
        cell.amountLabel.text = dummyData.values[index]
        
        if indexPath.row == 0 {
            cell.cellViewContainer.layer.cornerRadius = cell.cellViewContainer.frame.height/2
            cell.cellViewContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else if indexPath.row == dummyData.count - 1 {
            cell.cellViewContainer.layer.cornerRadius = cell.cellViewContainer.frame.height/2
            cell.cellViewContainer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
        
        return cell
    }
}
