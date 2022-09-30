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
    var forSell = true
    
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
    
    @IBOutlet weak var buyAmountContainer: UIView!
    @IBOutlet weak var buyAmount: UILabel!
    @IBOutlet weak var buyIcon: UIImageView!
    @IBOutlet weak var buyCurrency: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColor()
        setupBorders()
        setupMainConainterView()
        
        sellAmount.text = sellAmountVar
        buyAmount.text = buyAmountVar
        mainContainerView.bringSubviewToFront(convertCurrencyViewController.view)
    }
    
    func setupColor() {
        view.backgroundColor = ColorConstants.homeViewBackground
        topLabelViewContainer.backgroundColor = ColorConstants.homeViewContainersColor
        mainContainerView.backgroundColor = ColorConstants.homeViewContainersColor
        homeViewTopLabel.textColor = ColorConstants.homeViewTextColors
    }
    
    func setupBorders() {
        createRoundedBorder(of: sellCurrency, width: 2)
        createRoundedBorder(of: buyCurrency, width: 2)
        createRoundedBorder(of: buyAmountContainer, width: 2)
        createRoundedBorder(of: sellAmountContainer, width: 2)
    }
    
    func setupMainConainterView() {
        mainContainerView.layer.cornerRadius = Constants.cornerRadius
        mainContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        balanceViewController.dummyData = dummyData
        balanceViewController.tappedCurrencyDelegate = self
        addChild(balanceViewController)
        mainContainerView.addSubview(balanceViewController.view)
        balanceViewController.didMove(toParent: self)
        
        addChild(convertCurrencyViewController)
        convertCurrencyViewController.amountEnteredDelegate = self
        mainContainerView.addSubview(convertCurrencyViewController.view)
        convertCurrencyViewController.didMove(toParent: self)
    }
    
    @IBAction func sellcurrencyTapped(_ sender: UIButton) {
        forSell = true
        var newDummyData = dummyData
        newDummyData.removeValue(forKey: buyCurrency.titleLabel?.text ?? "")
        balanceViewController.dummyData = newDummyData
        balanceViewController.balanceTableView.reloadData()
        mainContainerView.bringSubviewToFront(balanceViewController.view)
    }
    
    @IBAction func buyCurrencyTapped(_ sender: UIButton) {
        forSell = false
        var newDummyData = dummyData
        newDummyData.removeValue(forKey: sellCurrency.titleLabel?.text ?? "")
        balanceViewController.dummyData = newDummyData
        balanceViewController.balanceTableView.reloadData()
        mainContainerView.bringSubviewToFront(balanceViewController.view)
    }
}

extension HomeViewController : TappedOnCurrency {
    func tappedCurrency(_ currency: String, having amount: String) {
        if forSell {
            guard let availAmount = Double(amount), availAmount > 0 else {
                let alertController = showAlertWith(title: Constants.error, and: "You have insufficient balance in your account")
                self.present(alertController, animated: true, completion: nil)
                return
            }
            sellCurrency.setTitle(currency, for: .normal)
            convertCurrencyViewController.sellCurrency = currency
            sellAmount.text = amount
        } else {
            buyCurrency.setTitle(currency, for: .normal)
            convertCurrencyViewController.buyCurrency = currency
            buyAmount.text = amount
        }
        mainContainerView.bringSubviewToFront(convertCurrencyViewController.view)
    }
}

extension HomeViewController: AmountEntered {
    func typedAmount(amount: String) {
        sellAmountVar = amount
        sellAmount.text = sellAmountVar
    }
}
