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
        
        balanceTableView.dataSource = self
        balanceTableView.delegate = self
        balanceTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let index = dummyData.index(dummyData.startIndex, offsetBy: indexPath.row)
        cell.backgroundColor = ColorConstants.homeViewBackground
        cell.textLabel?.text = "\(dummyData.keys[index]) \(dummyData.values[index])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = dummyData.index(dummyData.startIndex, offsetBy: indexPath.row)
        dummyData[dummyData.keys[index]] = "Changed"
        balanceTableView.reloadData()
    }
}
