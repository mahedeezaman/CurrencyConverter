//
//  HomeViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 26/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @Published var dummyData = [
        "EUR" : "1000.0",
        "USD" : "0.0",
        "JPY" : "0.0"
    ]
    
    let balanceViewController : AvailableBalanceViewController = {
        let balanceViewController = AvailableBalanceViewController()
        balanceViewController.view.backgroundColor = ColorConstants.homeViewBackground
        return balanceViewController
    }()
    
    let convertCurrencyViewController: ConvertCurrencyViewController = {
        let convertCurrencyVC = ConvertCurrencyViewController()
        convertCurrencyVC.view.backgroundColor = ColorConstants.homeViewBackground
        return convertCurrencyVC
    }()
    
    @IBOutlet weak var topLabelViewContainer: UIView!
    @IBOutlet weak var segmentedControlViewContainer: UIView!
    @IBOutlet weak var mainContainerView: UIView!
    
    @IBOutlet weak var segmentedControlOutlet: UISegmentedControl!
    @IBOutlet weak var homeViewTopLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColor()
        setupMainConainterView()
        segmentedControlOutlet.setupSegmentedControl()
        
        mainContainerView.bringSubviewToFront(balanceViewController.view)
    }
    
    func setupColor() {
        view.backgroundColor = ColorConstants.homeViewBackground
        segmentedControlViewContainer.backgroundColor = ColorConstants.homeViewBackground
        topLabelViewContainer.backgroundColor = ColorConstants.homeViewContainersColor
        mainContainerView.backgroundColor = ColorConstants.homeViewContainersColor
        homeViewTopLabel.textColor = ColorConstants.homeViewTextColors
    }
    
    func setupMainConainterView() {
        mainContainerView.layer.cornerRadius = Constants.cornerRadius
        mainContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        balanceViewController.dummyData = dummyData
        addChild(balanceViewController)
        mainContainerView.addSubview(balanceViewController.view)
        balanceViewController.didMove(toParent: self)
        
        addChild(convertCurrencyViewController)
        mainContainerView.addSubview(convertCurrencyViewController.view)
        convertCurrencyViewController.didMove(toParent: self)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mainContainerView.bringSubviewToFront(balanceViewController.view)
        case 1:
            mainContainerView.bringSubviewToFront(convertCurrencyViewController.view)
        default:
            mainContainerView.bringSubviewToFront(balanceViewController.view)
        }
    }
}

extension HomeViewController : ConvertedValue {
    func valueChanged(of currency: String, amount: String) {
        dummyData[currency] = amount
        balanceViewController.dummyData[currency] = amount
        balanceViewController.balanceTableView.reloadData()
    }
}
