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
    var buyAmountVar = ""
    var sellAmountVar = ""
    
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
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var homeViewTopLabel: UILabel!
    
    
    @IBOutlet weak var sellAmountContainer: UIView!
    @IBOutlet weak var sellAmount: UILabel!
    @IBOutlet weak var sellIcon: UIImageView!
    @IBOutlet weak var sellCurrency: UIButton!
    @IBOutlet weak var buyCurrencyChangeButton: UIButton!
    
    @IBOutlet weak var buyAmountContainer: UIView!
    @IBOutlet weak var buyAmount: UILabel!
    @IBOutlet weak var buyIcon: UIImageView!
    @IBOutlet weak var buyCurrency: UIButton!
    @IBOutlet weak var sellCurrencyChangeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColor()
        setupBorders()
        setupMainConainterView()
        
        sellAmount.text = sellAmountVar
        buyAmount.text = buyAmountVar
        mainContainerView.bringSubviewToFront(balanceViewController.view)
    }
    
    func setupColor() {
        view.backgroundColor = ColorConstants.homeViewBackground
        topLabelViewContainer.backgroundColor = ColorConstants.homeViewContainersColor
        mainContainerView.backgroundColor = ColorConstants.homeViewContainersColor
        homeViewTopLabel.textColor = ColorConstants.homeViewTextColors
    }
    
    func setupBorders() {
        sellAmountContainer.layer.borderColor = ColorConstants.homeViewContainersColor.cgColor
        sellAmountContainer.layer.borderWidth = 2
        sellAmountContainer.layer.cornerRadius = Constants.cornerRadius
        
        buyAmountContainer.layer.borderColor = ColorConstants.homeViewContainersColor.cgColor
        buyAmountContainer.layer.borderWidth = 2
        buyAmountContainer.layer.cornerRadius = Constants.cornerRadius
        
        sellCurrencyChangeButton.layer.borderColor = ColorConstants.homeViewContainersColor.cgColor
        sellCurrencyChangeButton.layer.borderWidth = 2
        sellCurrencyChangeButton.layer.cornerRadius = Constants.cornerRadius
        
        buyCurrencyChangeButton.layer.borderColor = ColorConstants.homeViewContainersColor.cgColor
        buyCurrencyChangeButton.layer.borderWidth = 2
        buyCurrencyChangeButton.layer.cornerRadius = Constants.cornerRadius
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
    
    @IBAction func sellcurrencyTapped(_ sender: UIButton) {
    }
    
    @IBAction func buyCurrencyTapped(_ sender: UIButton) {
    }
}

extension HomeViewController : ConvertedValue {
    func valueChanged(of currency: String, amount: String) {
        dummyData[currency] = amount
        balanceViewController.dummyData[currency] = amount
        balanceViewController.balanceTableView.reloadData()
    }
}
