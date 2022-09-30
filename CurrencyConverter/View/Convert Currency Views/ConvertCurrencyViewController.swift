//
//  ConvertCurrencyViewController.swift
//  CurrencyConverter
//
//  Created by Mahedee Zaman on 29/09/2022.
//

import UIKit

class ConvertCurrencyViewController: UIViewController {
    @IBOutlet var containerView: UIView!
    
    @IBOutlet weak var sellAmount: UILabel!
    @IBOutlet weak var sellAmountContainer: UIView!
    @IBOutlet weak var sellIcon: UIImageView!
    @IBOutlet weak var sellCurrency: UIButton!
    
    @IBOutlet weak var buyAmount: UILabel!
    @IBOutlet weak var buyAmountContainer: UIView!
    @IBOutlet weak var buyIcon: UIImageView!
    @IBOutlet weak var buyCurrency: UIButton!
    
    @IBOutlet weak var sellCurrencyChangeButton: UIButton!
    @IBOutlet weak var buyCurrencyChangeButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.backgroundColor = ColorConstants.homeViewContainersColor
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        setupBorders()
        submitButton.backgroundColor = ColorConstants.homeViewBackground
        submitButton.layer.cornerRadius = Constants.cornerRadius
    }
    
    func setupBorders() {
        sellAmountContainer.layer.borderColor = ColorConstants.homeViewBackground.cgColor
        sellAmountContainer.layer.borderWidth = 2
        sellAmountContainer.layer.cornerRadius = Constants.cornerRadius
        
        buyAmountContainer.layer.borderColor = ColorConstants.homeViewBackground.cgColor
        buyAmountContainer.layer.borderWidth = 2
        buyAmountContainer.layer.cornerRadius = Constants.cornerRadius
        
        sellCurrencyChangeButton.layer.borderColor = ColorConstants.homeViewBackground.cgColor
        sellCurrencyChangeButton.layer.borderWidth = 2
        sellCurrencyChangeButton.layer.cornerRadius = Constants.cornerRadius
        
        buyCurrencyChangeButton.layer.borderColor = ColorConstants.homeViewBackground.cgColor
        buyCurrencyChangeButton.layer.borderWidth = 2
        buyCurrencyChangeButton.layer.cornerRadius = Constants.cornerRadius
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func sellcurrencyTapped(_ sender: UIButton) {
    }
    
    @IBAction func buyCurrencyTapped(_ sender: UIButton) {
    }
    
    @IBAction func dialpadAdded(_ sender: UIButton) {
    }
    
    @IBAction func dialpadDeleted(_ sender: UIButton) {
    }
}
