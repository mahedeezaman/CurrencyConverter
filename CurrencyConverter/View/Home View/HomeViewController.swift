//
//  HomeViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 26/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    var currencyVM = CurrencyViewModel()
    var forSell = true
    
    let balanceViewController : AvailableBalanceViewController = {
        let balanceViewController = AvailableBalanceViewController()
        balanceViewController.view.backgroundColor = ColorConstants.homeViewBackground
        return balanceViewController
    }()
    
    let convertCurrController: ConvertCurrencyViewController = {
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
        
        sellAmount.text = currencyVM.currencyData.fromAmount
        buyAmount.text = currencyVM.currencyData.toAmount
        mainContainerView.bringSubviewToFront(convertCurrController.view)
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
        
        balanceViewController.availableCurrencyData = currencyVM.userData.accountBalances
        balanceViewController.tappedCurrencyDelegate = self
        addChild(balanceViewController)
        mainContainerView.addSubview(balanceViewController.view)
        balanceViewController.didMove(toParent: self)
        
        addChild(convertCurrController)
        convertCurrController.amountEnteredDelegate = self
        mainContainerView.addSubview(convertCurrController.view)
        convertCurrController.didMove(toParent: self)
    }
    
    @IBAction func sellcurrencyTapped(_ sender: UIButton) {
        forSell = true
        var newAccountBalances = currencyVM.userData.accountBalances
        newAccountBalances.removeValue(forKey: buyCurrency.titleLabel?.text ?? "")
        balanceViewController.availableCurrencyData = newAccountBalances
        balanceViewController.balanceTableView.reloadData()
        mainContainerView.bringSubviewToFront(balanceViewController.view)
    }
    
    @IBAction func buyCurrencyTapped(_ sender: UIButton) {
        forSell = false
        var newAccountBalances = currencyVM.userData.accountBalances
        newAccountBalances.removeValue(forKey: sellCurrency.titleLabel?.text ?? "")
        balanceViewController.availableCurrencyData = newAccountBalances
        balanceViewController.balanceTableView.reloadData()
        mainContainerView.bringSubviewToFront(balanceViewController.view)
    }
}
