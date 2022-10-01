//
//  AvailableBalanceViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 28/09/2022.
//

import UIKit

protocol TappedOnCurrency: AnyObject {
    func tappedCurrency(_ currency: String, having amount: String)
}

class AvailableBalanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var availableCurrencyData : [String : String] = [:]
    
    @IBOutlet weak var balanceTableView: UITableView!
    weak var tappedCurrencyDelegate : TappedOnCurrency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        balanceTableView.backgroundColor = ColorConstants.homeViewContainersColor
        balanceTableView.layer.cornerRadius = Constants.cornerRadius
        balanceTableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        balanceTableView.separatorColor = .clear
        
        balanceTableView.dataSource = self
        balanceTableView.delegate = self
        
        balanceTableView.registerCell(type: AvailableBalanceCellViewController.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availableCurrencyData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = availableCurrencyData.index(availableCurrencyData.startIndex, offsetBy: indexPath.row)
        tappedCurrencyDelegate?.tappedCurrency(availableCurrencyData.keys[index], having: availableCurrencyData.values[index])
        balanceTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: AvailableBalanceCellViewController.self, for: indexPath) else {
            return UITableViewCell()
        }
        
        let index = availableCurrencyData.index(availableCurrencyData.startIndex, offsetBy: indexPath.row)
        
        cell.backgroundColor = .clear
        cell.cellViewContainer.backgroundColor = ColorConstants.homeViewBackground
        
        cell.currencyLabel.text = availableCurrencyData.keys[index]
        cell.amountLabel.text = availableCurrencyData.values[index]
        cell.cellViewContainer.layer.cornerRadius = cell.cellViewContainer.frame.height/2
        
        return cell
    }
}
